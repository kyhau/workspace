#!/bin/bash
set -e
# https://github.com/trufflesecurity/trufflehog

mkdir -p ${HOME}/.local/bin

if [ -x "$(command -v trufflehog)" ]; then
  trufflehog --version
else
  echo "INFO: trufflehog not installed"
fi

echo "INFO: Installing trufflehog to ${HOME}/.local/bin"
curl -sSfL https://raw.githubusercontent.com/trufflesecurity/trufflehog/main/scripts/install.sh | sh -s -- -b ${HOME}/.local/bin

trufflehog --version
