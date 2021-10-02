#!/bin/bash
# kOps - Kubernetes Operations
# The easiest way to get a production grade Kubernetes cluster up and running.
# https://github.com/kubernetes/kops
set -e

curl -sLo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
chmod +x kops
mv kops ~/.local/bin/kops
