#!/bin/bash
# https://docs.docker.com/engine/install/ubuntu/

# Uninstall old versions
sudo apt-get remove docker docker-engine docker.io containerd runc

sudo apt update && sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker’s official GPG key
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
# curl -fsSL --insecure https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Use the following command to set up the repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install the latest version of Docker Engine - Community
sudo apt-get update && sudo apt-get install -y docker-ce docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
