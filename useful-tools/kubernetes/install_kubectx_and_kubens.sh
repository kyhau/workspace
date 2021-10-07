#!/bin/bash
# kubectx + kubens: Power tools for kubectl
# https://github.com/ahmetb/kubectx

set -e

mkdir -p ~/.local/bin

if [[ -d "~/.local/kubectx" ]]
then
  echo "INFO: git pull"
  cd ~/.local/kubectx
  git pull
  cd -
else
  echo "INFO: git clone ahmetb/kubectx into ~/.local/kubectx"
  git clone https://github.com/ahmetb/kubectx.git ~/.local/kubectx
  ln -s ~/.local/kubectx/kubectx ~/.local/bin/kubectx
  ln -s ~/.local/kubectx/kubens ~/.local/bin/kubens
fi
