#!/bin/bash
# Install Homebrew on Ubuntu
set -e

if [ -x "$(command -v brew)" ]; then
  echo "INFO: brew version: $(brew --version | grep 'Homebrew ' | awk -F' ' '{print $2}')"
else
  echo "INFO: brew not installed"
fi

echo "INFO: Installing Homebrew to /home/linuxbrew/.linuxbrew (default)"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh --insecure)"

# Add Homebrew to your PATH by running the following commands. These commands work on all major flavors of Linux by
# adding either ~/.profile on Debian/Ubuntu or ~/.bash_profile on CentOS/Fedora/RedHat:
echo "INFO: Adding Homebrew to your PATH"
test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile

echo "INFO: brew version: $(brew --version | grep 'Homebrew ' | awk -F' ' '{print $2}')"
