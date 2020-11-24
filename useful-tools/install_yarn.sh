#!/bin/bash
# Install Homebrew on Ubuntu
# https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install-linux.html
set -e

# https://classic.yarnpkg.com/en/docs/install/#debian-stable

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt update && sudo apt install yarn


# Fix "Error: getaddrinfo EAI_AGAIN registry.yarnpkg.com"
# Ref: https://github.com/yarnpkg/yarn/issues/2191

sudo apt-get install -y bind9-host
registryYarnpkgComIpAddress=$(host registry.yarnpkg.com | awk '/has address/ { print $4 }' | head -n1)
echo "${registryYarnpkgComIpAddress} registry.yarnpkg.com" >> /etc/hosts
