#!/bin/bash
# act - Run your GitHub Actions locally
# See https://github.com/nektos/act
set -e

APP_NAME=act

if [ -x "$(command -v ${APP_NAME})" ]; then
  echo "INFO: $(${APP_NAME} --version)"
else
  echo "INFO: ${APP_NAME} not installed"
fi

echo "INFO: Installing ${APP_NAME}"
curl https://raw.githubusercontent.com/nektos/act/master/install.sh -o install.sh
chmod +x install.sh

mkdir -p ${HOME}/.local
./install.sh -b ${HOME}/.local/bin

rm install.sh

echo "INFO: $(${APP_NAME} --version)"
