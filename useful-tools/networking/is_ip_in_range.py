"""
Check if IP(s) in any given ranges.
"""
import sys
from ipaddress import ip_address, ip_network

import click

is_in_range = lambda ip, cidr: ip_address(ip) in ip_network(cidr)


def read_file(filename):
    with open(filename, "r") as f:
        return list(set([line.split("\n")[0] for line in f.readlines()]))


@click.command(help="Find if IP(s) in cidr range(s).")
@click.option("--cidr", "-c", help="CIDR range to search.")
@click.option("--cidr-file", "-r", help="CIDRs to search (cidr per line).")
@click.option("--ip", "-i", help="IP address to search.")
@click.option("--ip-file", "-s", help="IP addresses to search (ip per line).")
def main(cidr, cidr_file, ip, ip_file):
    if not cidr and not cidr_file:
        print("Error: At least one CIDR needs to be provided. Aborted")
        sys.exit(1)
    if not ip and not ip_file:
        print("Error: At least one IP needs to be provided. Aborted")
        sys.exit(1)

    target_cidrs = [cidr] if cidr else read_file(cidr_file)
    target_ips = [ip] if ip else read_file(ip_file)

    print(f"Num of target CIDRs: {len(target_cidrs)}")
    print(f"Num of target IPs: {len(target_ips)}\n")

    for target_ip in target_ips:
        for target_cidr in target_cidrs:
            if is_in_range(target_ip, target_cidr):
                print(f"{target_ip} is in {target_cidr}")


if __name__ == "__main__":
     main()
