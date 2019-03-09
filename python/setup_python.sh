#!/bin/bash

# Run as root

# Install Python 2.7, 3.6, 3.7
apt-get install -y \
    python-minimal \
    python3-minimal \
    python2.7-dev \
    python3.6-dev \
    python3.7-dev \
    && apt-get -y clean

pushd /opt/

# Install pip via PyPA's recommended way rather than the outdated apt repos
# See: https://pip.pypa.io/en/stable/installing/
curl https://bootstrap.pypa.io/get-pip.py -o ./get-pip.py && \
    python2.7 get-pip.py && \
    python3.6 get-pip.py && \
    python3.7 get-pip.py
rm /opt/get-pip.py
popd

# Upgrade pip and install virtualenv
python2.7 -m pip install -U pip virtualenv && \
python3.6 -m pip install -U pip virtualenv && \
python3.7 -m pip install -U pip virtualenv

update-alternatives --install /usr/bin/python python /usr/bin/python3 1
python --version
