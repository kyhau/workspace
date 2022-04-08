#!/bin/bash

# https://github.com/wagoodman/dive


VERSION=$(curl "https://github.com/wagoodman/dive/tags" --insecure -s | grep "/wagoodman/dive/releases/tag/" | head -1 | awk -F '"' '{print $2}' | cut -c 31-)
FILENAME="dive_${VERSION}_linux_amd64.deb"
DOWNLOAD_LINK="https://github.com/wagoodman/dive/releases/download/v${VERSION}/${FILENAME}"

echo "INFO: Download and install dive v${VERSION}"

wget ${DOWNLOAD_LINK}
sudo apt install ./${FILENAME}

rm ${FILENAME}
