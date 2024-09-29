#!/bin/bash
# Set to fail script if any command fails.
set -e

WORKSPACES=${HOME}/Workspaces
WORKSPACE_REPO=${WORKSPACES}/github/workspace
CONFIGS_REPO=${WORKSPACES}/github/k-configs  # includes general dot files such as .zshrc, .aws, .config, .ssh, .gitconfig, .gitignore

# Prequisites
# Need these repos to be cloned first
echo "CheckPt $((step++)): Check ${WORKSPACE_REPO}"
[[ -e "${WORKSPACE_REPO}" ]] || { echo "${WORKSPACE_REPO} not exist - aborted"; return; }

echo "CheckPt $((step++)): Check ${CONFIGS_REPO}"
[[ -e "${CONFIGS_REPO}" ]] || { echo "${CONFIGS_REPO} not exist - aborted"; return; }

step=1

setup_homebrew() {
  # Install Homebrew to <user-home>/Applications folder instead of /Applications.
  [[ -d "${HOME}/Applications" ]] ||
  mkdir -p ${HOME}/Applications
  echo "CheckPt $((step++)): Install Homebrew"
  . ${WORKSPACE_REPO}/macos/install-homebrew.sh

  brew analytics off
}
# setup_homebrew

install_apps_with_brew() {
  # Install some general apps with brew
  echo "CheckPt $((step++)): Install apps with brew"
  . ${WORKSPACE_REPO}/macos/install-brew-packages.sh
}
# install_apps_with_brew

setup_workspace() {
  # Set up workspace with general dot files (config files)

  ################################################################################
  echo "CheckPt $((step++)): Set up .zshrc"
  cp ${CONFIGS_REPO}/.zshrc ~/.zshrc

  ################################################################################
  echo "CheckPt $((step++)): Set up .aws/config"
  [[ -d "${HOME}/.aws" ]] || mkdir -p ~/.aws
  cp ${CONFIGS_REPO}/.aws/config ~/.aws/config

  ################################################################################
  echo "CheckPt $((step++)): Set up .config/gh/config.yml"
  mkdir -p ~/.config/gh
  cp ${CONFIGS_REPO}/.config/gh/config.yml ~/.config/gh/config.yml

  ################################################################################
  echo "CheckPt $((step++)): Set up .config/pip/pip.conf"
  mkdir -p ~/.config/pip
  cp ${CONFIGS_REPO}/.config/pip/pip.conf ~/.config/pip/pip.conf

  ################################################################################
  echo "CheckPt $((step++)): Set up .ssh/config"
  [[ -d "${HOME}/.ssh" ]] || mkdir -p ${HOME}/.ssh
  cp ${CONFIGS_REPO}/.ssh/config ~/.ssh/config

  ################################################################################
  echo "CheckPt $((step++)): Set up git configs"
  cp ${CONFIGS_REPO}/.gitconfig-macos ~/.gitconfig
  cp ${CONFIGS_REPO}/.gitconfig-gh-k ~/.gitconfig-gh-k
  cp ${CONFIGS_REPO}/.gitconfig-gh-w ~/.gitconfig-gh-w
  cp ${CONFIGS_REPO}/.gitignore ~/.gitignore

  git config --global core.excludesFile '~/.gitignore'
  git lfs install
}
# setup_workspace

setup_dev_env() {
  # Set up development

  # Sourcing aliases to start
  source ${WORKSPACE_REPO}/.aliases-macos

  ################################################################################
  echo "CheckPt $((step++)): Set up kyhau/saml2aws-multi"
  cd ${WORKSPACES}/github/
  git clone https://github.com/kyhau/saml2aws-multi
  cd saml2aws-multi
  pip install -e .
  cd -

  ################################################################################
  echo "CheckPt $((step++)): Set up kyhau/aws-tools"
  cd ${WORKSPACES}/github/
  git clone https://github.com/kyhau/aws-tools
  cd -

  ################################################################################
  echo "CheckPt $((step++)): Set up vscode-configs"
  cd ${WORKSPACES}/github/
  git clone https://github.com/kyhau/vscode-configs
  cd -

  ################################################################################
  echo "CheckPt $((step++)): Set up virtualenvwrapper"
  pip install virtualenvwrapper

  # Sourcing aliases again to include new ones
  source ${WORKSPACE_REPO}/.aliases-macos
}
# setup_dev_env

setup_ln() {
  # Set up symbolic links
  WORKSPACES_BIN=${WORKSPACES}/bin
  echo "CheckPt $((step++)): Set up symbolic links folder ${WORKSPACES_BIN}"
  mkdir -p ${WORKSPACES_BIN}

  ln -s ${WORKSPACE_REPO}/macos/install-brew-packages.sh ${WORKSPACES_BIN}/install-brew-packages.sh
  ln -s ${WORKSPACE_REPO}/macos/update-dev-env.sh ${WORKSPACES_BIN}/update-dev-env.sh
  ln -s ${WORKSPACE_REPO}/.aliases-macos ${WORKSPACES_BIN}/.aliases-macos-workspace-k

  ln -s ${WORKSPACES}/github/aws-tools/.aliases-macos ${WORKSPACES_BIN}/.aliases-macos-awstools-k
}
# setup_ln
