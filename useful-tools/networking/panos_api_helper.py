"""
A simple PAN-OS API helper script finding firewall rule.

Author: Kay Hau <virtualda@gmail.com>
Repo: https://github.com/kyhau/workspace/tree/master/useful-tools/networking
"""
import json
import logging
from genericpath import exists
from os.path import exists, expanduser, join
from time import time
from urllib.parse import urlencode

import click
import urllib3
import xmltodict

logging.getLogger().setLevel(logging.INFO)
logging.getLogger("urllib3.connectionpool").setLevel(logging.CRITICAL)
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)


def read_json_file(filename):
    if not exists(filename):
        raise Exception(f"{filename} not found. Terminated")
    with open(filename, "r") as f:
        return json.load(f)


API_KEY_FILE = join(expanduser("~"), ".panos", "api_key.json")
API_KEY =  read_json_file(API_KEY_FILE)["ApiKey"]

# Contain {"fw-group-1": [url1, url2, ...]}
FW_URLS_FILE = join(expanduser("~"), ".panos", "fw_urls.json")
FIREWALLS = read_json_file(FW_URLS_FILE)
FW_GROUPS = FIREWALLS.keys()
if len(FW_GROUPS) == 0:
    raise Exception(f"{FW_URLS_FILE} contains no firewall group. Terminated")

http = urllib3.PoolManager(cert_reqs="CERT_NONE")

get_protocol = lambda x: 17 if x.lower() == "udp" else 6


class PanosXmlApiClient:
    """
    A PAN-OS XML API client for handling api queries
    """

    @staticmethod
    def send_api_request(f, cmd, retries=0):
        encoded_args = urlencode({"type": "op", "cmd": cmd, "key": API_KEY})
        url = f"https://{f}/api/?{encoded_args}"
        return http.request("GET", url, retries=retries)

    @staticmethod
    def system_info(f):
        cmd = "<show><system><info></info></system></show>"
        return PanosXmlApiClient.send_api_request(f, cmd)

    @staticmethod
    def security_policy_match(f, src_ip, dst_ip, protocol, dst_port):
        cmd = f"<test><security-policy-match>" \
            f"<source>{src_ip}</source>" \
            f"<destination>{dst_ip}</destination>" \
            f"<protocol>{protocol}</protocol>" \
            f"<destination-port>{dst_port}</destination-port>" \
            f"</security-policy-match></test>"

        resp = PanosXmlApiClient.send_api_request(f, cmd)

        data_dict = xmltodict.parse(resp.data)
        if resp.status == 200:
            result = data_dict["response"]["result"]["rules"]["entry"]
        else:
            result = data_dict["response"]

        # Convert OrderedDict to dict
        return json.loads(json.dumps(result))


def find_fw_url(fw_group):
    """Find the first reachable firewall of the given fw_group"""

    for f in FIREWALLS[fw_group]:
        try:
            logging.info(f"Checking {fw_group} {f}...")
            resp = PanosXmlApiClient.system_info(f)
            if resp.status == 200:
                return f

        except Exception as e:
            logging.error(e)
            logging.warning(f"{fw_group} {f} unreachable - skipped")


@click.command(help="Search firewall rule.")
@click.argument("src_ip")
@click.argument("dst_ip")
@click.argument("dst_port")
@click.option("--fw-group", "-g", required=True, type=click.Choice(FW_GROUPS, case_sensitive=False), help="Firewall group")
@click.option("--protocol", "-p", default="tcp", type=click.Choice(["tcp", "udp"], case_sensitive=False), help="Protocol")
def main(src_ip, dst_ip, dst_port, protocol, fw_group):
    start = time()
    try:
        fw_url = find_fw_url(fw_group)

        result = PanosXmlApiClient.security_policy_match(fw_url, src_ip, dst_ip, get_protocol(protocol), dst_port)
        result["firewall-url"] = fw_url

        print(json.dumps(result, indent=2))
    finally:
        logging.info(f"Total execution time: {time() - start}s")


if __name__ == "__main__":
     main()
