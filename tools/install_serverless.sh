#!/bin/bash
# Install https://github.com/serverless/serverless

echo "INFO: serverless version"
serverless --version

sudo npm config set registry https://registry.npmjs.org/

# sudo npm install -g npm

sudo npm install -g serverless

echo "INFO: serverless version"
serverless --version
