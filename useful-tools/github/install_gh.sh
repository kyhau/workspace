#!/bin/bash
# See also https://github.com/cli/cli/blob/trunk/docs/install_linux.md
set -e

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key C99B11DEB97541F0

# If seeing error
# ImportError: cannot import name '_gi' from partially initialized module 'gi' (most likely due to a circular import)
#sudo ln -s /usr/lib/python3/dist-packages/gi/_gi.cpython-{36m,37m,38}-x86_64-linux-gnu.so
#sudo apt-get install python3-pip
#sudo apt install libcairo2-dev -y
#sudo apt install libgirepository1.0-dev -y
#sudo python3.8 -m pip install --ignore-installed PyGObject

sudo apt-add-repository https://cli.github.com/packages
sudo apt update
sudo apt install gh
