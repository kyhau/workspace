#!/bin/bash
# https://github.com/snyk/cli
set -e

if [ -x "$(command -v snyk)" ]; then
  echo "INFO: snyk version installed: $(snyk --version)"
else
  echo "INFO: snyk not installed"
fi

echo "INFO: Downloading snyk"
curl -s --compressed https://static.snyk.io/cli/latest/snyk-linux -o snyk
chmod +x snyk

echo "INFO: Installing to ${HOME}/.local/bin/"
mkdir -p ${HOME}/.local/bin
mv snyk ${HOME}/.local/bin/

echo "INFO: snyk version: $(snyk --version)"
