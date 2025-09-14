#!/bin/bash
# kubectx + kubens: Power tools for kubectl
# https://github.com/ahmetb/kubectx

set -e

mkdir -p ${HOME}/.local/bin

if [[ -d "${HOME}/.local/kubectx" ]]
then
  echo "INFO: git pull"
  cd ${HOME}/.local/kubectx
  git pull
  cd -
else
  echo "INFO: git clone ahmetb/kubectx into ${HOME}/.local/kubectx"
  git clone https://github.com/ahmetb/kubectx.git ${HOME}/.local/kubectx
  ln -sfn ${HOME}/.local/kubectx/kubectx ${HOME}/.local/bin/kubectx
  ln -sfn ${HOME}/.local/kubectx/kubens ${HOME}/.local/bin/kubens
fi
