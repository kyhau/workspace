#!/bin/bash
# kOps - Kubernetes Operations
# The easiest way to get a production grade Kubernetes cluster up and running.
# https://github.com/kubernetes/kops
set -e

if [ -x "$(command -v kops)" ]; then
  echo "INFO: $(kops --version)"
else
  echo "INFO: kops not installed"
fi

echo "INFO: Downloading kOps"
curl -sLo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
chmod +x kops

echo "INFO: Moving binary to ${HOME}/.local/bin/"
mkdir -p ${HOME}/.local/bin
mv kops ${HOME}/.local/bin/kops

echo "INFO: $(kops --version)"
