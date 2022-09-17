#!/bin/bash
set -e

if [ -x "$(command -v git)" ]; then
  echo "INFO: $(git --version)"
else
  echo "INFO: git not installed"
fi

sudo add-apt-repository ppa:git-core/ppa -y
sudo apt-get update
sudo apt-get install git -y

echo "INFO: $(git --version)"
