#!/bin/bash

#sudo apt update && sudo apt-get install -y apt-transport-https software-properties-common

#add-apt-repository -y ppa:deadsnakes/ppa

# Install Python 3.9
#sudo apt-get install -y python3.9 python3.9-dev && sudo apt-get -y clean
sudo apt install -y python3.9 python3.9-dev

# Install pip via PyPA's recommended way rather than the outdated apt repos
# See: https://pip.pypa.io/en/stable/installing/
sudo apt install -y python3.9-venv python3-pip

curl https://bootstrap.pypa.io/get-pip.py --insecure -s -o ./get-pip.py && python3.9 get-pip.py && rm get-pip.py

# Upgrade pip and install virtualenv
python3.9 -m pip install -U pip virtualenvwrapper

# To use Python 3.9 as the default python3, run commands:
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 2

# sudo update-alternatives --config python3

cd /usr/bin

sudo rm python && sudo ln -s python3.9 python
sudo rm python3-config && sudo ln -s python3.9-config python3-config
sudo rm pydoc3 && sudo ln -s pydoc3.9 pydoc3
sudo rm pygettext3 && sudo ln -s pygettext3.9 pygettext3
sudo rm x86_64-linux-gnu-python3-config && sudo ln -s x86_64-linux-gnu-python3.9-config x86_64-linux-gnu-python3-config

cd -

echo "INFO: python version: $(python --version)"
echo "INFO: python3 version: $(python3 --version)"
