#!/bin/bash
set -e

echo "INFO: $(git --version)"

sudo add-apt-repository ppa:git-core/ppa -y
sudo apt-get update
sudo apt-get install git -y

echo "INFO: $(git --version)"
