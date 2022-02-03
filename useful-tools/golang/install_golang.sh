#!/bin/bash

# Approach 1: https://github.com/golang/go/wiki/Ubuntu
#sudo add-apt-repository -y ppa:longsleep/golang-backports
#sudo apt update
#sudo apt-get install -y golang-go
#sudo apt -y autoremove

# Approach 2: https://go.dev/doc/install

# Read page, find the first occurrence of /golang/go/releases/tag/go not containing "beta"
# e.g. <a href="/golang/go/releases/tag/go1.17.6">
VERSION=$(curl --silent "https://github.com/golang/go/tags" --insecure -s | grep "/golang/go/releases/tag/go" | grep -v beta | head -1 | awk -F '"' '{print $2}' | cut -c 27-)
DOWNLOAD_LINK="https://go.dev/dl/go${VERSION}.linux-amd64.tar.gz"

wget ${DOWNLOAD_LINK}

mkdir -p ${HOME}/.local
rm -rf ${HOME}/.local/go
tar -C ${HOME}/.local -xzf go${VERSION}.linux-amd64.tar.gz
rm go${VERSION}.linux-amd64.tar.gz

ln -sfn ${HOME}/.local/go/bin/go ${HOME}/.local/bin/go
ln -sfn ${HOME}/.local/go/bin/gofmt ${HOME}/.local/bin/gofmt

echo "INFO: $(go version)"

# go run test1.go
