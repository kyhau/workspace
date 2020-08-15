#!/bin/bash

# Run as root

# Reinstall?
## Find all dependencies:
#dpkg -l | grep python3.6
## Remove all of them:
#apt-get --purge remove libpython3.6 libpython3.6-dev libpython3.6-minimal libpython3.6-stdlib python3.6 python3.6-dev python3.6-minimal

apt update && apt-get install -y \
  apt-transport-https \
  curl \
  software-properties-common

#add-apt-repository -y ppa:deadsnakes/ppa

# Install Python 3.8
apt-get install -y \
  python3.8 \
  python3.8-dev \
  && apt-get -y clean

# Install pip via PyPA's recommended way rather than the outdated apt repos
# See: https://pip.pypa.io/en/stable/installing/
sudo apt install -y python3-venv python3-pip

#pushd /opt/
#curl https://bootstrap.pypa.io/get-pip.py -o ./get-pip.py && python3.8 get-pip.py
#rm /opt/get-pip.py
#popd

# Upgrade pip and install virtualenv
python3.8 -m pip install -U pip virtualenv virtualenvwrapper wheel

# Update Python3 default version in Ubuntu
# https://unix.stackexchange.com/questions/410579/change-the-python3-default-version-in-ubuntu
update-alternatives --install /usr/bin/python python /usr/bin/python3.6 1
update-alternatives --install /usr/bin/python python /usr/bin/python3.8 2
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1

python --version
python3 --version
