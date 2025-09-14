#!/bin/bash
# https://github.com/helm/helm
# Modified from https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
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

if [ -x "$(command -v helm)" ]; then
  echo "INFO: helm version: $(helm version)"
else
  echo "INFO: helm not installed"
fi

TAG=$(curl -Ls https://github.com/helm/helm/releases | grep 'href="/helm/helm/releases/tag/v3.[0-9]*.[0-9]*\"' | grep -v no-underline | head -n 1 | cut -d '"' -f 6 | awk '{n=split($NF,a,"/");print a[n]}' | awk 'a !~ $0{print}; {a=$0}')

HELM_DIST="helm-$TAG-$OS-$ARCH.tar.gz"
DOWNLOAD_URL="https://get.helm.sh/$HELM_DIST"

echo "INFO: Downloading $DOWNLOAD_URL"
curl -SsL "$DOWNLOAD_URL" -o $HELM_DIST

echo "INFO: Moving binary to ${HOME}/.local/bin/"
mkdir -p tmp
tar xf $HELM_DIST -C tmp
cp tmp/$OS-$ARCH/helm ${HOME}/.local/bin/
rm -rf tmp
rm ${HELM_DIST}

echo "INFO: helm version: $(helm version)"
