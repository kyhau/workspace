#!/bin/bash
# Set to fail script if any command fails.
set -e

# Assume the same username is used in both Ubuntu and Windows account
UNAME=$(whoami)
WIN_WORKSPACES=/c/Workspaces
WIN_USER_HOME=/c/Users/${UNAME}
WSL_HOME=/home/${UNAME}

step=1
echo $step

echo "CheckPt $((step++)): apt upgrade"
sudo apt-get update && sudo apt install ca-certificates && sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade && sudo apt-get -y autoremove && sudo apt-get -y autoclean

echo "CheckPt $((step++)): apt install"
sudo apt install -y build-essential dos2unix git jq

echo "CheckPt $((step++)): Check git installed"
git --version

echo "CheckPt $((step++)): Setup .ssh"
[[ -d "${WIN_USER_HOME}/.ssh" ]] || mkdir -p ${WIN_USER_HOME}/.ssh
[[ -e "${WLS_HOME}/.ssh/.ssh_wins" ]] || ln -s ${WIN_USER_HOME}/.ssh ${WLS_HOME}/.ssh/.ssh_wins
chmod 600 ${WIN_USER_HOME}/.ssh/*

echo "CheckPt $((step++)): Check workspace setup"
[[ -e "${WIN_WORKSPACES}/github/workspace" ]] || { echo "Not exist - aborted"; return; }

echo "CheckPt $((step++)): Check k-configs setup"
[[ -e "${WIN_WORKSPACES}/github/k-configs" ]] || { echo "Not exist - aborted"; return; }


################################################################################
# Setup chmod/chown support
# See https://superuser.com/questions/1323645/unable-to-change-file-permissions-on-ubuntu-bash-for-windows-10).
# Note that the `umount/mount` approach in
# https://blogs.msdn.microsoft.com/commandline/2018/01/12/chmod-chown-wsl-improvements/)
# does not work (error on re-mounting).
echo "CheckPt $((step++)): Copy wsl.conf for chmod/chown support"
sudo cp ${WIN_WORKSPACES}/github/workspace/ubuntu/wsl.conf /etc/wsl.conf

################################################################################
# Setup config files and symbolic links

echo "CheckPt $((step++)): Setup .bashrc"
ln -s ${WIN_WORKSPACES}/github/k-configs/.bashrc ${WLS_HOME}/.bashrc

echo "CheckPt $((step++)): Setup .gitconfig"
ln -s ${WIN_WORKSPACES}/github/k-configs/.gitconfig-wsl ${WLS_HOME}/.gitconfig

echo "CheckPt $((step++)): Setup workspaces"
[[ ! -d "${WIN_USER_HOME}/workspaces" ]] || [[ -e "${WLS_HOME}/workspaces" ]] || ln -s ${WIN_WORKSPACES}/ ${WLS_HOME}/workspaces
source ${WLS_HOME}/workspaces/.aliases

echo "CheckPt $((step++)): Setup .aws"
[[ -d "${WIN_USER_HOME}/.aws" ]] || mkdir -p ${WIN_USER_HOME}/.aws
[[ -e "${WLS_HOME}/.aws" ]] || ln -s ${WIN_USER_HOME}/.aws ${WLS_HOME}/.aws

################################################################################
# Set up git

touch "${WIN_USER_HOME}/.gitignore"
[[ -e "${WLS_HOME}/.gitignore" ]] || ln -s ${WIN_USER_HOME}/.gitignore ${WLS_HOME}/.gitignore
git config --global core.excludesfile ${WLS_HOME}/.gitignore

# Required by git-secrets
# [[ -d  "${WIN_USER_HOME}/.git-templates" ]] || mkdir "${WIN_USER_HOME}/.git-templates"
# [[ -e "${WLS_HOME}/.git-templates" ]] || ln -s "${WIN_USER_HOME}/.git-templates" "${WLS_HOME}/.git-templates"

# touch "${WIN_USER_HOME}/.git-secrets"
# [[ -e "${WLS_HOME}/.git-secrets" ]] || ln -s "${WIN_USER_HOME}/.git-secrets" "${WLS_HOME}/.git-secrets"
# echo "CheckPt $((step++)): Install git_secrets"
# . ${WIN_WORKSPACES}/github/workspace/useful-tools/git_secrets/install_git_secrets.sh


################################################################################
echo "CheckPt $((step++)): Install Python, pip, virtualenvwrapper, etc."
. ${WIN_WORKSPACES}/github/workspace/useful-tools/python/install_python.sh

################################################################################
echo "CheckPt $((step++)): Install saml2aws"
. ${WIN_WORKSPACES}/github/aws-tools/saml2aws/install_saml2aws.sh

touch ${WIN_USER_HOME}/.saml2aws
ln -s ${WIN_USER_HOME}/.saml2aws ~/

################################################################################
# WSL2 has Docker Integration
echo "CheckPt $((step++)): Install Docker"
. ${WIN_WORKSPACES}/github/workspace/useful-tools/install_docker.sh
