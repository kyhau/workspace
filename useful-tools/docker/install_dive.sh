#!/bin/bash
# A tool for exploring each layer in a docker image
# https://github.com/wagoodman/dive

if [ -x "$(command -v dive)" ]; then
  echo "INFO: dive version: $(dive --version)"
else
  echo "INFO: dive not installed"
fi

VERSION=$(curl "https://github.com/wagoodman/dive/tags" --insecure -s | grep "/wagoodman/dive/releases/tag/" | head -1 | awk -F '"' '{print $2}' | cut -c 31-)
FILENAME="dive_${VERSION}_linux_amd64.deb"
DOWNLOAD_LINK="https://github.com/wagoodman/dive/releases/download/v${VERSION}/${FILENAME}"

echo "INFO: Installing dive v${VERSION}"

wget ${DOWNLOAD_LINK}
sudo apt install ./${FILENAME}

rm ${FILENAME}

echo "INFO: dive version: $(dive --version)"
