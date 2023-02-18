#!/bin/bash
# Set to fail script if any command fails.
set -e

# Assume the same username is used in both Ubuntu and Windows account
UNAME=$(whoami)
WIN_WORKSPACES=/c/Workspaces
WIN_USER_HOME=/c/Users/${UNAME}
WSL_USER_HOME=/home/${UNAME}

step=1
echo $step

# Need ${WIN_WORKSPACES}/github/workspace to be cloned first
echo "CheckPt $((step++)): Check ${WIN_WORKSPACES}/github/workspace (windows)"
[[ -e "${WIN_WORKSPACES}/github/workspace" ]] || { echo "Not exist - aborted"; return; }


setup_wsl () {
  # Setup mnt mapping
  # Setup chmod/chown support
  # See https://superuser.com/questions/1323645/unable-to-change-file-permissions-on-ubuntu-bash-for-windows-10).
  # Note that the `umount/mount` approach in
  # https://blogs.msdn.microsoft.com/commandline/2018/01/12/chmod-chown-wsl-improvements/)
  # does not work (error on re-mounting).
  echo "CheckPt $((step++)): Copy wsl.conf for chmod/chown support"
  sudo cp ${WIN_WORKSPACES}/github/workspace/ubuntu/wsl.conf /etc/wsl.conf

  echo nameserver 8.8.8.8 | sudo tee /etc/resolv.conf
}
# setup_wsl


setup_ssh () {
  echo "CheckPt $((step++)): Setup .ssh (windows)"
  [[ -d "${WIN_USER_HOME}/.ssh" ]] || mkdir -p ${WIN_USER_HOME}/.ssh

  echo "CheckPt $((step++)): Setup .ssh (ubuntu)"
  [[ -d "${WSL_USER_HOME}/.ssh" ]] || mkdir -p ${WSL_USER_HOME}/.ssh
  [[ -e "${WSL_USER_HOME}/.ssh/.ssh_wins" ]] || ln -sf ${WIN_USER_HOME}/.ssh ${WSL_USER_HOME}/.ssh/.ssh_wins
  cp ${WIN_USER_HOME}/.ssh/* ${WSL_USER_HOME}/.ssh/
  chmod 400 ${WSL_USER_HOME}/.ssh/*

  eval "$(ssh-agent -s)"
  ssh-add ${WSL_USER_HOME}/.ssh/id_rsa
}
# setup_ssh


update_ubuntu () {
  echo "CheckPt $((step++)): apt upgrade"
  sudo apt-get update && sudo apt install ca-certificates && sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade && sudo apt-get -y autoremove && sudo apt-get -y autoclean

  echo "CheckPt $((step++)): apt install"
  sudo apt install -y build-essential dos2unix git jq

  echo "CheckPt $((step++)): Check git installed"
  git --version
}
# update_ubuntu


setup_workspace () {
  echo "CheckPt $((step++)): Check ${WSL_USER_HOME}/workspaces (ubuntu)"
  ln -sf ${WIN_WORKSPACES} ${WSL_USER_HOME}/workspaces

  ################################################################################
  echo "CheckPt $((step++)): Setup k-configs (ubuntu/windows)"
  if [[ ! -d "${WIN_WORKSPACES}/github/k-configs" ]]; then
    cd ${WIN_WORKSPACES}/github/
    git clone git@github.com:kyhau/k-configs.git
    cd -
  fi

  ################################################################################
  echo "CheckPt $((step++)): Setup .bashrc (ubuntu)"
  rm ${WSL_USER_HOME}/.bashrc
  ln -sf ${WIN_WORKSPACES}/github/k-configs/.bashrc ${WSL_USER_HOME}/.bashrc

  ################################################################################
  echo "CheckPt $((step++)): Setup .profile (ubuntu)"
  rm ${WSL_USER_HOME}/.profile
  ln -sf ${WIN_WORKSPACES}/github/k-configs/.profile ${WSL_USER_HOME}/.profile

  ################################################################################
  echo "CheckPt $((step++)): Setup .gitconfig (windows)"
  cp ${WIN_WORKSPACES}/github/k-configs/.gitconfig-gh-k ${WIN_USER_HOME}/.gitconfig-gh-k
  cp ${WIN_WORKSPACES}/github/k-configs/.gitconfig-gh-w ${WIN_USER_HOME}/.gitconfig-gh-w
  cp ${WIN_WORKSPACES}/github/k-configs/.gitconfig ${WIN_USER_HOME}/.gitconfig

  echo "CheckPt $((step++)): Setup .gitconfig (ubuntu)"
  ln -sf ${WIN_WORKSPACES}/github/k-configs/.gitconfig-gh-k ${WSL_USER_HOME}/.gitconfig-gh-k
  ln -sf ${WIN_WORKSPACES}/github/k-configs/.gitconfig-gh-w ${WSL_USER_HOME}/.gitconfig-gh-w
  ln -sf ${WIN_WORKSPACES}/github/k-configs/.gitconfig-wsl ${WSL_USER_HOME}/.gitconfig

  ################################################################################
  echo "CheckPt $((step++)): Setup .gitignore (windows)"
  # touch "${WIN_USER_HOME}/.gitignore"
  cp ${WIN_WORKSPACES}/github/k-configs/.gitignore ${WIN_USER_HOME}/.gitignore

  echo "CheckPt $((step++)): Setup .gitignore (ubuntu)"
  ln -sf ${WIN_USER_HOME}/.gitignore ${WSL_USER_HOME}/.gitignore
  # git config --global core.excludesfile ${WSL_USER_HOME}/.gitignore

  ################################################################################
  echo "CheckPt $((step++)): Setup .aws (ubuntu/windows)"
  [[ -d "${WIN_USER_HOME}/.aws" ]] || mkdir -p ${WIN_USER_HOME}/.aws
  ln -sf ${WIN_USER_HOME}/.aws ${WSL_USER_HOME}/.aws

  ################################################################################
  source ${WSL_USER_HOME}/workspaces/github/workspace/.aliases
}
# setup_workspace


setup_docker () {
  ################################################################################
  # Note that WSL2 has Docker Integration
  echo "CheckPt $((step++)): Install Docker"
  . ${WIN_WORKSPACES}/github/workspace/useful-tools/install_docker.sh
}
# setup_docker


setup_dev () {
  ################################################################################
  echo "CheckPt $((step++)): Install Python, pip, virtualenvwrapper, etc."
  . ${WIN_WORKSPACES}/github/workspace/useful-tools/python/install_python.sh

  ################################################################################
  echo "CheckPt $((step++)): Install saml2aws"
  . ${WIN_WORKSPACES}/github/aws-tools/saml2aws/install_saml2aws.sh

  ################################################################################
  # touch ${WIN_USER_HOME}/.saml2aws
  # ln -sf ${WIN_USER_HOME}/.saml2aws ~/

  # Required by git-secrets
  # [[ -d  "${WIN_USER_HOME}/.git-templates" ]] || mkdir "${WIN_USER_HOME}/.git-templates"
  # [[ -e "${WSL_USER_HOME}/.git-templates" ]] || ln -sf "${WIN_USER_HOME}/.git-templates" "${WSL_USER_HOME}/.git-templates"

  # touch "${WIN_USER_HOME}/.git-secrets"
  # [[ -e "${WSL_USER_HOME}/.git-secrets" ]] || ln -sf "${WIN_USER_HOME}/.git-secrets" "${WSL_USER_HOME}/.git-secrets"
  # echo "CheckPt $((step++)): Install git_secrets"
  # . ${WIN_WORKSPACES}/github/workspace/useful-tools/git_secrets/install_git_secrets.sh
}
# setup_dev
