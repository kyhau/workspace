#!/bin/bash
# Install NVM
# See also https://github.com/nvm-sh/nvm
set -e

REPO=nvm-sh/nvm

function install_package() {
  echo "INFO: Downloading nvm"
  curl -o- https://raw.githubusercontent.com/${REPO}/${VERSION}/install.sh | bash
}

# This line would be better but may have Rate limit issue
# VERSION=$(curl -s "https://api.github.com/repos/${REPO}/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')
VERSION=$(curl -s https://github.com/${REPO}/releases | grep "<h2 class=\"sr-only" | head -1 | awk -F '>' '{print $2}' | awk -F '<' '{print $1}')
echo "INFO: nvm latest release ${VERSION}"

if [[ ! -z "$NVM_DIR" && -d "$NVM_DIR" ]]; then
  if [[ "v$(nvm -v)" == "${VERSION}" ]]; then
    echo "INFO: Already installed the latest"
  else
    install_package
  fi
else
  echo "INFO: nvm not installed"
  install_package
fi

echo "INFO: $(nvm -v)"
