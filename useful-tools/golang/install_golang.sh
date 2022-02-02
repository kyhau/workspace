#!/bin/bash

# Approach 1: https://github.com/golang/go/wiki/Ubuntu
#sudo add-apt-repository -y ppa:longsleep/golang-backports
#sudo apt update
#sudo apt-get install -y golang-go
#sudo apt -y autoremove

# Approach 2: https://go.dev/doc/install

VERSION="1.17.6"
DOWNLOAD_LINK="https://go.dev/dl/go${VERSION}.linux-amd64.tar.gz"

wget ${DOWNLOAD_LINK}

mkdir -p ${HOME}/.local
rm -rf ${HOME}/.local/go
tar -C ${HOME}/.local -xzf go${VERSION}.linux-amd64.tar.gz
rm go${VERSION}.linux-amd64.tar.gz

ln -sfn ${HOME}/.local/go/bin/go ${HOME}/.local/bin/go
ln -sfn ${HOME}/.local/go/bin/gofmt ${HOME}/.local/bin/gofmt

echo "INFO: go version: $(go version)"

go run test1.go
