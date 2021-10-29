#!/bin/bash
# See also https://github.com/nodesource/distributions#debmanual

VERSION=16.x

# Remove current installations, if any
#sudo apt-get --purge remove node

curl -sSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key --insecure | sudo apt-key add -

#curl -sL https://deb.nodesource.com/setup_${VERSION} --insecure | sudo -E bash -
#sudo apt-get install -y nodejs

####################################################################################
# https://github.com/nodesource/distributions#manual-installation

# The below command will set this correctly, but if lsb_release isn't available, you can set it manually:
# - For Debian distributions: jessie, sid, etc...
# - For Ubuntu distributions: xenial, bionic, etc...
# - For Debian or Ubuntu derived distributions your best option is to use the codename corresponding to the upstream release your distribution is based off. This is an advanced scenario and unsupported if your distribution is not listed as supported per earlier in this README.
DISTRO="$(lsb_release -s -c)"
echo "deb http://deb.nodesource.com/node_$VERSION $DISTRO main" | sudo tee /etc/apt/sources.list.d/nodesource.list
echo "deb-src http://deb.nodesource.com/node_$VERSION $DISTRO main" | sudo tee -a /etc/apt/sources.list.d/nodesource.list

sudo apt-get update && sudo apt-get install nodejs

echo "node version: $(node --version)"
echo "npm version: $(npm --version)"
