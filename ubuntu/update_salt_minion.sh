#!/bin/bash

if [[ $EUID -ne 0 ]]; then
 echo "This script must be run as root"
 exit 1
fi

wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
sudo echo 'deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main' > /etc/apt/sources.list.d/saltstack.list
sudo echo 'deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/archive/2019.2.0 xenial main' >> /etc/apt/sources.list.d/saltstack.list

apt-get update

sudo apt-get install -y salt-minion=2019.2.0+ds-1 salt-common=2019.2.0+ds-1

systemctl restart salt-minion
salt-minion --version
