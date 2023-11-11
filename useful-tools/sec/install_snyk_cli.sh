#!/bin/bash
# https://github.com/snyk/cli
set -e

if [ -x "$(command -v snyk)" ]; then
  echo "INFO: snyk version installed: $(snyk --version)"
else
  echo "INFO: snyk not installed"
fi

mkdir -p ${HOME}/.local/bin

echo "INFO: Installing snyk"

curl --compressed https://static.snyk.io/cli/latest/snyk-linux -o snyk
chmod +x ./snyk
mv ./snyk ${HOME}/.local/bin/snyk

echo "INFO: snyk version: $(snyk --version)"
