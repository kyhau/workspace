#!/bin/bash
# Install https://github.com/kyhau/arki

set -e

SRC_HOME="$( cd "$( dirname -- "$0" )" && pwd )/arki"

if [[ -d "${SRC_HOME}/arki" ]]; then
  echo "$SRC_HOME already exists"
else
  echo "Cloning arki to $SRC_HOME"
  git clone git@github.com:kyhau/arki.git ${SRC_HOME}/arki
fi

# Add the following to your .bashrc
# [[ ! -f "${SRC_HOME}/arki/.aliases" ]] || . ${SRC_HOME}/arki/.aliases
