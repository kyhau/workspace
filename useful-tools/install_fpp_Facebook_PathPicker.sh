#!/bin/bash
# Install Facebook PathPicker https://github.com/facebook/PathPicker
set -e

mkdir -p ${HOME}/.local/bin

echo "INFO: Get latest source from facebook/PathPicker into ${HOME}/.local/PathPicker"

[[ -d "${HOME}/.local/PathPicker" ]] || git clone https://github.com/facebook/PathPicker ${HOME}/.local/PathPicker

cd ${HOME}/.local/PathPicker
git pull
cd -

ln -sfn ${HOME}/.local/PathPicker/fpp ${HOME}/.local/bin/fpp

echo "TODO: Add 'export EDITOR=nano' to ${HOME}/.bashrc"
