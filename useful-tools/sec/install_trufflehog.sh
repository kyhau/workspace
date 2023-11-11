#!/bin/bash
# https://github.com/trufflesecurity/trufflehog
set -e

VERSION=$(curl -s "https://api.github.com/repos/trufflesecurity/trufflehog/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")' | sed 's/^v//')
echo "INFO: trufflehog latest: ${VERSION}"

CURR_VERSION=
if [ -x "$(command -v trufflehog)" ]; then
  CURR_VERSION=$(trufflehog --version 2>&1 | awk '{print $2}')
  echo "INFO: trufflehog installed: ${CURR_VERSION}"
else
  echo "INFO: trufflehog not installed"
fi

if [ "${VERSION}" != "${CURR_VERSION}" ]; then
  echo "INFO: Installing to ${HOME}/.local/bin/"
  mkdir -p ${HOME}/.local/bin
  curl -sSfL https://raw.githubusercontent.com/trufflesecurity/trufflehog/main/scripts/install.sh | sh -s -- -b ${HOME}/.local/bin

  echo "INFO: trufflehog installed: $(trufflehog --version 2>&1 | awk '{print $2}')"
fi
