#!/bin/bash
set -e

# Approach 1: https://github.com/golang/go/wiki/Ubuntu
#sudo add-apt-repository -y ppa:longsleep/golang-backports
#sudo apt update
#sudo apt-get install -y golang-go
#sudo apt -y autoremove

# Approach 2: https://go.dev/doc/install

if [ -x "$(command -v go)" ]; then
  echo "INFO: $(go version)"
else
  echo "INFO: go not installed"
fi

# Read page, find the first occurrence of /golang/go/releases/tag/go not containing "beta"
# e.g. <a href="/golang/go/releases/tag/go1.17.6">
VERSION=$(curl "https://github.com/golang/go/tags" --insecure -s | grep "/golang/go/releases/tag/go" | grep -v beta | head -1 | awk -F 'tag/go' '{print $2}' | awk -F '"' '{print $1}')
GO_FILENAME=go${VERSION}.linux-amd64.tar.gz
DOWNLOAD_LINK="https://go.dev/dl/${GO_FILENAME}"

wget -q ${DOWNLOAD_LINK} -O ${GO_FILENAME}

mkdir -p ${HOME}/.local
rm -rf ${HOME}/.local/go
tar -C ${HOME}/.local -xzf ${GO_FILENAME}
rm ${GO_FILENAME}

ln -sfn ${HOME}/.local/go/bin/go ${HOME}/.local/bin/go
ln -sfn ${HOME}/.local/go/bin/gofmt ${HOME}/.local/bin/gofmt

echo "INFO: $(go version)"

# go run test1.go
