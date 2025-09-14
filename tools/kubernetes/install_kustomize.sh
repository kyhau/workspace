#!/bin/bash
# https://kustomize.docs.kubernetes.io/installation/kustomize/binaries/
set -e

if [ -x "$(command -v kustomize)" ]; then
  echo "INFO: kustomize version: $(kustomize version | awk -F[:/\ ] '{ print $3}')"
else
  echo "INFO: kustomize not installed"
fi

echo "INFO: Downloading kustomize"
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash

echo "INFO: Moving binary to ${HOME}/.local/bin/"
mkdir -p ${HOME}/.local/bin
mv kustomize ${HOME}/.local/bin/

echo "INFO: kustomize version: $(kustomize version | awk -F[:/\ ] '{ print $3}')"
