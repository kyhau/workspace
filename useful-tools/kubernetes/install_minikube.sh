#!/bin/bash
# minikube implements a local Kubernetes cluster on macOS, Linux, and Windows.
# https://github.com/kubernetes/minikube
# https://minikube.sigs.k8s.io/docs/start/
set -e

echo "Downloading the latest version of kubernetes/minikube..."

curl -sLO "https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64"

echo "Installing to ~/.local/bin..."
mkdir -p ~/.local/bin
install minikube-linux-amd64 ~/.local/bin/minikube
rm minikube-linux-amd64

echo "Checking version..."
echo "minikube version: $(minikube version)"
