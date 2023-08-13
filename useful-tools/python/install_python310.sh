#!/bin/bash

sudo apt update && sudo apt upgrade -y

sudo apt install software-properties-common -y
sudo add-apt-repository ppa:deadsnakes/ppa

sudo apt install -y python3.10

sudo apt install -y \
  python3.10-dev \
  python3.10-minimal \
  python3.10-venv \
  python3-pip

# Install pip via PyPA's recommended way rather than the outdated apt repos
# See: https://pip.pypa.io/en/stable/installation/
curl -SsL https://bootstrap.pypa.io/get-pip.py -o ./get-pip.py && python3.10 get-pip.py && rm get-pip.py

# Upgrade pip and install virtualenv
python3.10 -m pip install -U pip virtualenvwrapper

# To use Python 3.10 as the default python3, run commands:
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 2
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 3
sudo update-alternatives --config python3

cd /usr/bin

sudo rm python && sudo ln -s python3.10 python
sudo rm pydoc3 && sudo ln -s pydoc3.10 pydoc3
sudo rm pygettext3 && sudo ln -s pygettext3.10 pygettext3
sudo ln -s x86_64-linux-gnu-python3.10-config python3.10-config
sudo rm python3-config && sudo ln -s python3.10-config python3-config

cd -

echo "python version: $(python --version)"
echo "python3 version: $(python3 --version)"
