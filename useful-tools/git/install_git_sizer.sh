#!/bin/bash
# https://github.com/github/git-sizer
set -e

if [ -x "$(command -v git-sizer)" ]; then
  echo "INFO: git-sizer version: $(git-sizer --version)"
else
  echo "INFO: git-sizer not installed"
fi

VERSION=$(curl "https://github.com/github/git-sizer/tags" --insecure -s | grep "/github/git-sizer/releases/tag/" | head -1 | awk -F '"' '{print $6}' | cut -c 33-)
FILENAME="git-sizer-${VERSION}-linux-amd64.zip"
DOWNLOAD_LINK="https://github.com/github/git-sizer/releases/download/v${VERSION}/${FILENAME}"

echo "INFO: Installing git-sizer v${VERSION}"

wget ${DOWNLOAD_LINK}

mkdir -p ${HOME}/.local/bin

unzip ${FILENAME} -d git-sizer-${VERSION}

mv git-sizer-${VERSION}/git-sizer ${HOME}/.local/bin/git-sizer

rm ${FILENAME}
rm -rf git-sizer-${VERSION}

echo "INFO: git-sizer version: $(git-sizer --version)"
