#!/bin/bash
# https://skaffold.dev/docs/install/
set -e

ARCH=$(uname -m)
case $ARCH in
  armv5*) ARCH="armv5";;
  armv6*) ARCH="armv6";;
  armv7*) ARCH="arm";;
  aarch64) ARCH="arm64";;
  x86) ARCH="386";;
  x86_64) ARCH="amd64";;
  i686) ARCH="386";;
  i386) ARCH="386";;
esac

OS=$(echo `uname`|tr '[:upper:]' '[:lower:]')
case "$OS" in
  # Minimalist GNU for Windows
  mingw*) OS='windows';;
esac

[[ -f "${HOME}/.local/bin/skaffold" ]] && \
echo "INFO: skaffold version: $(skaffold version)"

echo "INFO: Downloading binary"
curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-${ARCH}

echo "INFO: Installing binary to ${HOME}/.local/bin/"
install skaffold ${HOME}/.local/bin/

rm skaffold

echo "INFO: skaffold version: $(skaffold version)"
