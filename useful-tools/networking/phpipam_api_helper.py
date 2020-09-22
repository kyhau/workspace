"""
A simple phpIPAM API helper script for finding possible subnets of the given IP addresses.

Author: Kay Hau <virtualda@gmail.com>
Repo: https://github.com/kyhau/workspace/tree/master/useful-tools/networking

Notes:
1. Create App ID and token, see https://phpipam.net/api/api_curl_example/
2. Test access: curl -X GET https://<url>/api/<appname>/addresses/tags/ -i --header 'token: <app-token>' --insecure
3. url_rewrite is required for API to work. See https://phpipam.net/api-documentation/
4. See https://github.com/phpipam/phpipam/issues/2624
"""
import json
import logging
from collections import defaultdict
from ipaddress import ip_address, ip_network
from os.path import exists, expanduser, join
from time import time

import click
import urllib3

logging.getLogger().setLevel(logging.INFO)
logging.getLogger("urllib3.connectionpool").setLevel(logging.CRITICAL)
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

LOCAL_DATA_FILE = join(expanduser("~"), ".ipam", "data.json")
TOKEN_FILE = join(expanduser("~"), ".ipam", "token.json")
with open(TOKEN_FILE, "r") as f:
    config_data = json.load(f)
API_PATH = config_data["ApiPath"]
APP_TOKEN = config_data["AppToken"]

http = urllib3.PoolManager(cert_reqs="CERT_NONE")

is_in_range = lambda ip, cidr: ip_address(ip) in ip_network(cidr)


class IpamApiHelper:
    """
    Provide functions to send API requests to IPAM
    """
    def __init__(self, refresh=False) -> None:
        self._subnets = IpamApiHelper.read_ipam_data_from_file(refresh)

    @staticmethod
    def send_ipam_api_request(path, retries=0):
        resp = http.request("GET", f"{API_PATH}{path}", headers={"token": APP_TOKEN}, retries=retries)
        logging.info(f"Response: {resp.status}")

        data = json.loads(resp.data.decode("utf-8"))
        result = data["data"] if resp.status == 200 else data
        return result

    @staticmethod
    def read_ipam_data_from_file(refresh):
        if refresh is True or not exists(LOCAL_DATA_FILE):
            subnets = IpamApiHelper.save_ipam_data_to_file()
        else:
            with open(LOCAL_DATA_FILE, "r") as f:
                subnets = json.load(f)
        logging.info(f"Number of subnets: {len(subnets)}")
        return subnets

    @staticmethod
    def save_ipam_data_to_file():
        # Get sections
        sections = []
        items = IpamApiHelper.send_ipam_api_request("sections/")
        for item in items:
            sections.append({k: v for k, v in item.items() if k in ["id", "name"]})

        subnets = []
        for section in sections:
            id = section["id"]
            items = IpamApiHelper.send_ipam_api_request(f"sections/{id}/subnets/")

            for item in items:
                if item["subnet"] is None or item["mask"] is None:
                    continue

                subnets.append({
                    "cidr": f'{item["subnet"]}/{item["mask"]}',
                    "description": item["description"],
                    "section": section["name"],
                    "sectionId": item["sectionId"],
                    "subnetId": item["id"],
                })

        with open(LOCAL_DATA_FILE, "w") as outfile:
            json.dump(subnets, outfile, indent=2, sort_keys=True, default=str)
            logging.info(f"Updated {LOCAL_DATA_FILE}")

        return subnets

    def find_ips(self, ips):
        results = defaultdict(list)
        for item in self._subnets:
            for ip in ips:
                if is_in_range(ip, item["cidr"]):
                    results[ip].append(item)
        return results


@click.command(help="Search possible subnets of the given IP address.")
@click.option("--ip", "-i", required=True, help="IP address to search.")
@click.option("--refresh", "-r", show_default=True, is_flag=True, help="Refresh local copy of IPAM data.")
def main(refresh, ip):
    start = time()
    try:
        results = IpamApiHelper(refresh).find_ips([ip])
        print(json.dumps(results, indent=2))
    finally:
        logging.info(f"Total execution time: {time() - start}s")


if __name__ == "__main__":
     main()
