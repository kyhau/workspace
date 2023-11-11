#!/bin/bash
# https://github.com/github/git-sizer
set -e

VERSION=$(curl -s "https://api.github.com/repos/github/git-sizer/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")' | sed 's/^v//')
echo "INFO: git-sizer latest: ${VERSION}"

CURR_VERSION=
if [ -x "$(command -v git-sizer)" ]; then
  CURR_VERSION=$(git-sizer --version 2>&1 | awk '{print $3}')
  echo "INFO: git-sizer installed: ${CURR_VERSION}"
else
  echo "INFO: git-sizer not installed"
fi

if [ "${VERSION}" != "${CURR_VERSION}" ]; then
  echo "INFO: Downloading git-sizer"
  FILE_NAME=git-sizer-${VERSION}-linux-amd64.zip
  FILE_URL="https://github.com/github/git-sizer/releases/download/v${VERSION}/${FILE_NAME}"
  WORK_DIR=/tmp/tmp_workdir

  wget ${FILE_URL} -O /tmp/${FILE_NAME} --no-check-certificate -q
  mkdir -p ${WORK_DIR}
  unzip /tmp/${FILE_NAME} -d ${WORK_DIR}

  echo "INFO: Installing to ${HOME}/.local/bin/"
  mkdir -p ${HOME}/.local/bin
  mv ${WORK_DIR}/git-sizer ${HOME}/.local/bin/

  rm -rf ${WORK_DIR} /tmp/${FILE_NAME}

  echo "INFO: git-sizer installed: $(git-sizer --version 2>&1 | awk '{print $3}')"
fi
