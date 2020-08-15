#!/bin/bash
# https://github.com/cli/cli
# Releases: https://github.com/cli/cli/releases/

VERSION="0.11.1"

wget --no-check-certificate "https://github.com/cli/cli/releases/download/v${VERSION}/gh_${VERSION}_linux_amd64.deb"
sudo apt install ./gh_*_linux_amd64.deb
rm -rf gh_*_linux_amd64.deb
