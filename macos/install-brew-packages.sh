#!/bin/bash
set -e

app_list=(
  curl  # export PATH="$HOME/Applications/homebrew/opt/curl/bin:$PATH"
  dos2unix
  go
  jq
  nvm
  # openjdk # export PATH="$HOME/Applications/homebrew/opt/openjdk/bin:$PATH"

  ## python related
  uv
  # pyenv
  # readline  # for pyenv
  # xz  # for pyenv

  ## aws related
  awscli
  saml2aws

  ## git / github related
  # act
  git-lfs
  gh

  ## scanner
  # gitleaks
  # osv-scanner
  # snyk-cli
  trufflehog

  ## docker related
  # dive
  # docker  # Docker. For Docker Desktop, use cast_app_list.
  # lazydocker

  ## k8s related
  helm
  kubectl
  # k9s
  # kops
  # krew
  # kubectx
  # minikube
  # skaffold
)

cast_app_list=(
  amazon-q  # Amazon Q
  cursor
  cursor-cli
  docker  # Docker Desktop
  github  # GitHub Desktop
  lens
  visual-studio-code@insiders
  # windsurf  # Windsurf
)

# Check if the app is installed and install it if it is not with brew
for app in "${app_list[@]}"; do
  if ! command -v "$app" &> /dev/null; then
    brew install "$app"
  else
    brew upgrade "$app"
  fi
done

# Check if the app is installed and install it if it is not with brew
for app in "${cast_app_list[@]}"; do
  if ! command -v "$app" &> /dev/null; then
    brew install --cask "$app"
  else
    brew upgrade "$app"
  fi
done
