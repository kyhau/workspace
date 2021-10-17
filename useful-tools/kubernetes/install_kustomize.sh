#!/bin/bash
# https://kubectl.docs.kubernetes.io/installation/kustomize/binaries/

set -e

echo "INFO: Downloading kustomize"
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash

echo "INFO: Moving binary to ${HOME}/.local/bin/"
mkdir -p ${HOME}/.local/bin
mv kustomize ${HOME}/.local/bin/

echo "INFO: Checking version"
echo "kustomize version: $(kustomize version)"
