#!/bin/bash
# Install Facebook PathPicker
# https://github.com/facebook/PathPicker
set -e

mkdir -p ${HOME}/.local/bin

if [[ -d "${HOME}/.local/PathPicker" ]]
then
  echo "INFO: git pull"
  cd ${HOME}/.local/PathPicker
  git pull
  cd -
else
  echo "INFO: git clone facebook/PathPicker into ${HOME}/.local/PathPicker"
  git clone https://github.com/facebook/PathPicker ${HOME}/.local/PathPicker
  ln -sfn ${HOME}/.local/PathPicker/fpp ${HOME}/.local/bin/fpp
fi

echo "TODO: Add 'export EDITOR=nano' to ${HOME}/.bashrc"
