#!/bin/bash
# Set to fail script if any command fails.
set -e

# Assume the same username is used in both Ubuntu and Windows account
UNAME=$(whoami)

sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade && sudo apt-get -y autoremove && sudo apt-get -y autoclean

sudo apt install -y build-essential dos2unix jq shellcheck

ROOT_DIR="/c"

################################################################################
# Setup chmod/chown support
# See https://superuser.com/questions/1323645/unable-to-change-file-permissions-on-ubuntu-bash-for-windows-10).
# Note that the `umount/mount` approach in
# https://blogs.msdn.microsoft.com/commandline/2018/01/12/chmod-chown-wsl-improvements/)
# does not work (error on re-mounting).
echo "CheckPt: chmod/chown support"
sudo cp ${ROOT_DIR}/Workspaces/github/workspace/ubuntu/wsl.conf /etc/wsl.conf


################################################################################
echo "CheckPt: Setup config files and symbolic links"

[[ ! -d "${ROOT_DIR}/Users/${UNAME}/workspaces" ]] || [[ -e "$HOME/workspaces" ]] || ln -s ${ROOT_DIR}/Workspaces/ "$HOME/workspaces"

[[ -d "${ROOT_DIR}/Users/${UNAME}/.aws" ]] || mkdir -p "${ROOT_DIR}/Users/${UNAME}/.aws"
[[ -e "$HOME/.aws" ]] || ln -s "${ROOT_DIR}/Users/${UNAME}/.aws" "$HOME/.aws"

[[ -d "${ROOT_DIR}/Users/${UNAME}/.ssh" ]] || mkdir -p "${ROOT_DIR}/Users/${UNAME}/.ssh"
[[ -e "$HOME/.ssh/.ssh_wins" ]] || ln -s "${ROOT_DIR}/Users/${UNAME}/.ssh" "$HOME/.ssh/.ssh_wins"
chmod 600 ${ROOT_DIR}/Users/${UNAME}/.ssh/*


################################################################################
echo "CheckPt: Install git"
sudo apt install -y git

echo "CheckPt: Setup git global configs"
git config --global core.autocrlf false
git config --global color.ui auto

touch "${ROOT_DIR}/Users/${UNAME}/.gitignore"
[[ -e "$HOME/.gitignore" ]] || ln -s "${ROOT_DIR}/Users/${UNAME}/.gitignore" "$HOME/.gitignore"
git config --global core.excludesfile "$HOME/.gitignore"

# Required by git-secrets
[[ -d  "${ROOT_DIR}/Users/${UNAME}/.git-templates" ]] || mkdir "${ROOT_DIR}/Users/${UNAME}/.git-templates"
[[ -e "$HOME/.git-templates" ]] || ln -s "${ROOT_DIR}/Users/${UNAME}/.git-templates" "$HOME/.git-templates"

touch "${ROOT_DIR}/Users/${UNAME}/.git-secrets"
[[ -e "$HOME/.git-secrets" ]] || ln -s "${ROOT_DIR}/Users/${UNAME}/.git-secrets" "$HOME/.git-secrets"
echo "CheckPt: Install git_secrets"
. ${ROOT_DIR}/Workspaces/github/workspace/useful-tools/git_secrets/install_git_secrets.sh


################################################################################
# WSL2 has Docker Integration
# echo "CheckPt: Install Docker"
#. ${ROOT_DIR}/Workspaces/github/workspace/useful-tools/install_docker.sh


################################################################################
echo "CheckPt: Install Python, pip, virtualenvwrapper, etc."
. ${ROOT_DIR}/Workspaces/github/workspace/useful-tools/python/install_python.sh


################################################################################
echo "CheckPt: Install saml2aws"
. ${ROOT_DIR}/Workspaces/github/aws-tools/saml2aws/install_saml2aws.sh

touch ${ROOT_DIR}/Users/${UNAME}/.saml2aws
ln -s ${ROOT_DIR}/Users/${UNAME}/.saml2aws ~/


################################################################################
echo "CheckPt: Install node"
. ${ROOT_DIR}/Workspaces/github/workspace/useful-tools/nodejs/install_nodejs.sh

