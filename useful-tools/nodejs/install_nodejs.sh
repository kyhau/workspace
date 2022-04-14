#!/bin/bash
set -e
# See also https://github.com/nodesource/distributions/blob/master/README.md#debinstall

VERSION=16.x

echo "INFO: node version: $(node --version)"
echo "INFO: npm version: $(npm --version)"

# Remove current installations, if any
#sudo apt-get --purge remove node

curl -fsSL -k https://deb.nodesource.com/setup_${VERSION} | sudo -E bash -
sudo apt-get install -y nodejs

echo "INFO: node version: $(node --version)"
echo "INFO: npm version: $(npm --version)"
