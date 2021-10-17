#!/bin/bash
# minikube implements a local Kubernetes cluster on macOS, Linux, and Windows.
# https://github.com/kubernetes/minikube
# https://minikube.sigs.k8s.io/docs/start/
set -e

echo "INFO: Downloading kubernetes/minikube"
curl -sLO "https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64"

echo "INFO: Installing to ${HOME}/.local/bin/"
mkdir -p ${HOME}/.local/bin
install minikube-linux-amd64 ${HOME}/.local/bin/minikube
rm minikube-linux-amd64

echo "INFO: Checking version"
echo "minikube version: $(minikube version)"
