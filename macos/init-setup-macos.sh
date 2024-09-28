#!/bin/bash
# Set to fail script if any command fails.
set -e

WORKSPACES=${HOME}/Workspaces
WORKSPACE_REPO=${WORKSPACES}/github/workspace
CONFIGS_REPO=${CONFIGS_REPO}

# Prequisites
# Need these repos to be cloned first
echo "CheckPt $((step++)): Check ${WORKSPACE_REPO}"
[[ -e "${WORKSPACE_REPO}" ]] || { echo "${WORKSPACE_REPO} not exist - aborted"; return; }

echo "CheckPt $((step++)): Check ${CONFIGS_REPO}"
[[ -e "${CONFIGS_REPO}" ]] || { echo "${CONFIGS_REPO} not exist - aborted"; return; }

step=1

setup_homebrew() {
  mkdir -p ${HOME}/Applications
  echo "CheckPt $((step++)): Install Homebrew"
  . ${WORKSPACE_REPO}/macos/install-homebrew.sh

  brew analytics off
}
# setup_homebrew

install_apps_with_brew() {
  echo "CheckPt $((step++)): Install apps with brew"
  . ${WORKSPACE_REPO}/macos/install-or-upgrade-apps.sh
}
# install_apps_with_brew

setup_workspace() {

  ################################################################################
  echo "CheckPt $((step++)): Set up .zshrc"
  cp ${CONFIGS_REPO}/.zshrc ~/.zshrc

  ################################################################################
  echo "CheckPt $((step++)): Set up .aws"
  [[ -d "${HOME}/.aws" ]] || mkdir -p ~/.aws
  cp ${CONFIGS_REPO}/.aws/config ~/.aws/config

  ################################################################################
  echo "CheckPt $((step++)): Set up .config"
  [[ -d "${HOME}/.config" ]] || mkdir -p ~/.config

  mkdir -p ~/.config/gh
  cp ${CONFIGS_REPO}/.config/gh/config.yml ~/.config/gh/config.yml

  mkdir -p ~/.config/pip
  cp ${CONFIGS_REPO}/.config/pip/pip.conf ~/.config/pip/pip.conf

  ################################################################################
  echo "CheckPt $((step++)): Set up .ssh"
  [[ -d "${HOME}/.ssh" ]] || mkdir -p ${HOME}/.ssh
  cp ${CONFIGS_REPO}/.ssh/config ~/.ssh/config

  ################################################################################
  echo "CheckPt $((step++)): Set up .git configs"
  cp ${CONFIGS_REPO}/.gitconfig-macos ~/.gitconfig
  cp ${CONFIGS_REPO}/.gitconfig-gh-k ~/.gitconfig-gh-k
  cp ${CONFIGS_REPO}/.gitconfig-gh-w ~/.gitconfig-gh-w
  cp ${CONFIGS_REPO}/.gitignore ~/.gitignore

  git config --global core.excludesFile '~/.gitignore'
  git lfs install

  ################################################################################
  source ~/workspaces/github/workspace/.aliases
}
# setup_workspace

setup_dev () {
  ################################################################################
  echo "CheckPt $((step++)): Set up saml2aws-multi"
  cd ${WORKSPACES}/github/w
  git clone https://github.com/kyhau/saml2aws-multi
  cd saml2aws-multi
  pip install -e .
  cd -

  ################################################################################
  echo "CheckPt $((step++)): Set up vscode-configs"
  cd ${WORKSPACES}/github/w
  git clone https://github.com/kyhau/vscode-configs
  cd -
}