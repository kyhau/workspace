#!/bin/bash
set -e

function check_e() {
  item=$1
  status="** [NOT_EXIST]"
  [ ! -e "$1" ] || status=OK
  echo "CHECK: $status ${1}"
}

function check_x() {
  item=$1
  status="** [NOT_INSTALLED]"
  [ ! -x "$(command -v $1)" ] || status=OK
  echo "CHECK: $status ${1} - $(which $1)"
}

########################################
# Start checking

echo "INFO: whoami: $(whoami)"
echo "INFO: HOME: ${HOME}"

ROOT_DIR="/c"
echo "cINFO: ROOT_DIR: ${ROOT_DIR}"

check_e /etc/wsl.conf

########################################
# Check workspaces
WORKSPACE_DIR="/c/Workspaces"
check_e ${WORKSPACE_DIR}/
check_e ${WORKSPACE_DIR}/github/

########################################
# Check $HOME config
check_e ${HOME}/.aws/
check_e ${HOME}/.aws/config
check_e ${HOME}/.bashrc
check_e ${HOME}/.config/
check_e ${HOME}/.config/gh/
check_e ${HOME}/.docker/
check_e ${HOME}/.gitconfig
check_e ${HOME}/.gitignore
check_e ${HOME}/.local/
check_e ${HOME}/.profile
check_e ${HOME}/.saml2aws
check_e ${HOME}/.ssh/
check_e ${HOME}/workspaces/

########################################
# Check installations
check_x aws
check_x brew
check_x cdk
check_x docker
check_x dos2unix
check_x eksctl
check_x gh
check_x git
check_x git-secrets
check_x go
check_x jq
check_x helm
check_x kubectl
check_x minikube
check_x ncc
check_x node
check_x npm
check_x npx
check_x nvm
check_x pip
check_x pip3
check_x python
check_x python3
check_x sam
check_x saml2aws
check_x skaffold
check_x tsc
check_x yamllint
check_x yarn
