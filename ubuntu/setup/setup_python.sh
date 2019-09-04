#!/bin/bash

# Run as root

# Reinstall?
## Find all dependencies:
#dpkg -l | grep python3.6
## Remove all of them:
#apt-get --purge remove libpython3.6 libpython3.6-dev libpython3.6-minimal libpython3.6-stdlib python3.6 python3.6-dev python3.6-minimal

apt update && apt-get install -y software-properties-common
add-apt-repository -y ppa:deadsnakes/ppa

# Install Python 3.7
apt-get install -y \
    python3.7-dev \
    python3.7-distutils \
    && apt-get -y clean

cd /opt/

# Install pip via PyPA's recommended way rather than the outdated apt repos
# See: https://pip.pypa.io/en/stable/installing/
curl https://bootstrap.pypa.io/get-pip.py -o ./get-pip.py && \
    python3.7 get-pip.py

rm /opt/get-pip.py
popd

# Upgrade pip and install virtualenv
python3.7 -m pip install -U pip virtualenv virtualenvwrapper wheel

update-alternatives --install /usr/bin/python python /usr/bin/python3 1
python --version
