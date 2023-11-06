#!/bin/bash
set -e
# https://github.com/stamparm/maltrail

mkdir -p ${HOME}/.local/bin

sudo apt-get install git python3 python3-dev python3-pip python-is-python3 libpcap-dev build-essential procps schedtool
sudo pip3 install pcapy

echo "INFO: Get latest source from stamparm/maltrail into ${HOME}/.local/maltrail"

[[ -d "${HOME}/.local/maltrail" ]] || git clone --depth 1 https://github.com/stamparm/maltrail ${HOME}/.local/maltrail

cd ${HOME}/.local/maltrail
git pull
cd -

ln -sfn ${HOME}/.local/maltrail/fpp ${HOME}/.local/bin/fpp

echo "TODO: Add alias maltrail=python3 ${HOME}/.local/maltrail/sensor.py'"
