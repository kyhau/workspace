#!/bin/bash
# See https://github.com/gitleaks/gitleaks
set -e

VERSION=$(curl -s "https://api.github.com/repos/gitleaks/gitleaks/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")' | sed 's/^v//')
echo "INFO: gitleaks latest: ${VERSION}"

CURR_VERSION=
if [ -x "$(command -v gitleaks)" ]; then
  CURR_VERSION=$(gitleaks version 2>&1)
  echo "INFO: gitleaks installed: ${CURR_VERSION}"
else
  echo "INFO: gitleaks not installed"
fi

if [ "${VERSION}" != "${CURR_VERSION}" ]; then
  echo "INFO: Downloading gitleaks"
  FILE_NAME=gitleaks_${VERSION}_linux_x64.tar.gz
  FILE_URL="https://github.com/gitleaks/gitleaks/releases/download/v${VERSION}/${FILE_NAME}"
  WORK_DIR=/tmp/tmp_workdir

  wget ${FILE_URL} -O /tmp/${FILE_NAME} --no-check-certificate -q
  mkdir -p ${WORK_DIR}
  tar xfz /tmp/${FILE_NAME} -C ${WORK_DIR}

  echo "INFO: Installing to ${HOME}/.local/bin/"
  mkdir -p ${HOME}/.local/bin
  mv ${WORK_DIR}/gitleaks ${HOME}/.local/bin/

  rm -rf ${WORK_DIR} /tmp/${FILE_NAME}

  echo "INFO: gitleaks installed: $(gitleaks version 2>&1)"
fi
