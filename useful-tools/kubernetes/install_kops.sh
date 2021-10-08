#!/bin/bash
# kOps - Kubernetes Operations
# The easiest way to get a production grade Kubernetes cluster up and running.
# https://github.com/kubernetes/kops
set -e

echo "INFO: Downloading kOps"
curl -sLo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
chmod +x kops

echo "INFO: Moving binary to ~/.local/bin/"
mkdir -p ~/.local/bin
mv kops ~/.local/bin/kops
