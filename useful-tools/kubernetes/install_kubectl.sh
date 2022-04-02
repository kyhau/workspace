#!/bin/bash
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
set -e

echo "INFO: Downloading kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

echo "INFO: Moving binary to ${HOME}/.local/bin/"
mkdir -p ${HOME}/.local/bin
chmod +x kubectl
mv kubectl ${HOME}/.local/bin/

echo "INFO: Checking version"
echo kubectl version: $(kubectl version --client --output=yaml | grep gitVersion | awk -F ": " '{print $2}')
