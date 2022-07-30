#!/bin/bash
# Install NVM
# See also https://github.com/nvm-sh/nvm
set -e

REPO=nvm-sh/nvm

VERSION=$(curl --silent "https://api.github.com/repos/${REPO}/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')
echo "INFO: nvm latest release ${VERSION}"

if [ -x "$(command -v nvm)" ]; then
  echo "INFO: $(nvm --version)"
else
  echo "INFO: nvm not installed"
fi

echo "INFO: Downloading nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${VERSION}/install.sh | bash
echo "INFO: $(nvm --version)"
