#!/bin/bash

# Run as root

apt update && apt-get install -y software-properties-common
add-apt-repository -y ppa:deadsnakes/ppa

# Install Python 3.7, 3.8
apt-get install -y \
    python3.7-dev \
    python3.8-dev \
    python3.8-distutils \
    && apt-get -y clean

cd /opt/

# Install pip via PyPA's recommended way rather than the outdated apt repos
# See: https://pip.pypa.io/en/stable/installing/
curl https://bootstrap.pypa.io/get-pip.py -o ./get-pip.py && \
    python3.8 get-pip.py && \
    python3.7 get-pip.py && \

rm /opt/get-pip.py
popd

# Upgrade pip and install virtualenv
python3.8 -m pip install -U pip virtualenv virtualenvwrapper wheel
python3.7 -m pip install -U pip virtualenv virtualenvwrapper wheel

update-alternatives --install /usr/bin/python python /usr/bin/python3 1
python --version
