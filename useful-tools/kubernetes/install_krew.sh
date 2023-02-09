#!/bin/bash
# https://krew.sigs.k8s.io/docs/user-guide/setup/install/
# Krew itself is a kubectl plugin that is installed and updated via Krew (yes, Krew self-hosts).
set -e

if [ -x "$(command -v kubectl krew)" ]; then
  echo "INFO: krew version: $(kubectl krew version | grep GitTag | awk -F' ' '{print $2}')"
else
  echo "INFO: krew not installed"
fi

echo "INFO: Downloading krew"
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz"
  ./"${KREW}" install krew
)

echo "INFO: krew version: $(kubectl krew version | grep GitTag | awk -F' ' '{print $2}')"
