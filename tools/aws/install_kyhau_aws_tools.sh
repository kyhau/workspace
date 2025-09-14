#!/bin/bash
# Install https://github.com/kyhau/aws-tools

set -e

SRC_HOME="$( cd "$( dirname -- "$0" )" && pwd )/aws-tools"

if [[ -d "${SRC_HOME}/aws-tools" ]]; then
  echo "$SRC_HOME already exists"
else
  echo "Cloning aws-tools to $SRC_HOME"
  git clone git@github.com:kyhau/aws-tools.git ${SRC_HOME}/aws-tools
fi

# Add the following to your .bashrc
# [[ ! -f "${SRC_HOME}/aws-tools/.aliases" ]] || . ${SRC_HOME}/aws-tools/.aliases
