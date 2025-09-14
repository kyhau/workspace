#!/bin/bash
set -e

sudo apt update && sudo apt upgrade -y

sudo add-apt-repository ppa:deadsnakes/ppa

# sudo apt install software-properties-common -y

# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
sudo apt install build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev curl \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

sudo apt install -y python3.12

sudo apt install -y \
  python3.12-dev \
  python3.12-minimal \
  python3.12-venv \
  python3-pip

# Install pip via PyPA's recommended way rather than the outdated apt repos
# See: https://pip.pypa.io/en/stable/installation/
curl -SsL https://bootstrap.pypa.io/get-pip.py -o ./get-pip.py && python3.12 get-pip.py && rm get-pip.py

# To use Python 3.12 as the default python3, run commands:
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 2
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.12 3
sudo update-alternatives --config python3

cd /usr/bin

sudo ln -sf python3.12 python
sudo ln -sf pydoc3.12 pydoc3
sudo ln -sf pygettext3.12 pygettext3
sudo ln -sf x86_64-linux-gnu-python3.12-config python3.12-config
sudo ln -sf x86_64-linux-gnu-python3.12-config x86_64-linux-gnu-python3-config
sudo ln -sf python3.12-config python3-config

cd -

echo "python version: $(python --version)"
echo "python3 version: $(python3 --version)"

python3.12 -m pip install -U setuptools virtualenvwrapper
