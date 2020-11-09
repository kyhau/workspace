#!/bin/bash

# Uninstall old versions
sudo apt-get remove docker docker-engine docker.io containerd runc

sudo apt update && sudo apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  software-properties-common

curl -fsSL --insecure https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"


# Install the latest version of Docker Engine - Community
sudo apt-get update && apt-get install -y docker-ce
  # docker-ce-cli containerd.io
