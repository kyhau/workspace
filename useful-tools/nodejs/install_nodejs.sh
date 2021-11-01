#!/bin/bash
# See also https://github.com/nodesource/distributions/blob/master/README.md#debinstall

VERSION=16.x

# Remove current installations, if any
#sudo apt-get --purge remove node

curl -fsSL -k https://deb.nodesource.com/setup_${VERSION} | sudo -E bash -
sudo apt-get install -y nodejs

echo "node version: $(node --version)"
echo "npm version: $(npm --version)"
