#!/bin/bash
# Install Facebook PathPicker
# https://github.com/facebook/PathPicker
set -e

WORKSPACE_DIR="$HOME/workspaces/github"

pushd $WORKSPACE_DIR

[[ -d "PathPicker" ]] || git clone https://github.com/facebook/PathPicker

pushd PathPicker/debian
./package.sh

pushd ~/.local/bin/
[ -e fpp ] && rm -f fpp
ln -s ${WORKSPACE_DIR}/PathPicker/fpp .

popd
popd
popd

echo "TODO:  Add 'export EDITOR=nano' to ~/.bashrc"
