#!/bin/bash

set -e

# string formatters
if [[ -t 1 ]]; then
  tty_escape() { printf "\033[%sm" "$1"; }
else
  tty_escape() { :; }
fi
tty_mkbold() { tty_escape "1;$1"; }
tty_underline="$(tty_escape "4;39")"
tty_blue="$(tty_mkbold 34)"
tty_red="$(tty_mkbold 31)"
tty_bold="$(tty_mkbold 39)"
tty_reset="$(tty_escape 0)"

H_HOME="$HOME/Applications"

export HOMEBREW_PREFIX="$H_HOME/homebrew"
export HOMEBREW_CELLAR="$H_HOME/homebrew/Cellar"
export HOMEBREW_REPOSITORY="$H_HOME/homebrew"

mkdir -p "$HOMEBREW_PREFIX"
curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C "$HOMEBREW_PREFIX"
export PATH="$H_HOME/homebrew/bin:$H_HOME/homebrew/sbin${PATH+:$PATH}"
brew update -f

echo "Next steps:"
case "$SHELL" in
  */bash*)
    if [[ -r "$HOME/.bash_profile" ]]; then
      shell_profile="$HOME/.bash_profile"
    else
      shell_profile="$HOME/.profile"
    fi
    ;;
  */zsh*)
    shell_profile="$HOME/.zshrc"
    ;;
  *)
    shell_profile="$HOME/.profile"
    ;;
esac
cat <<EOS
- Automatically add Homebrew to your ${tty_bold}PATH${tty_reset} in ${tty_underline}${shell_profile}${tty_reset} by running this:
    echo 'eval "\$(~/Applications/homebrew/bin/brew shellenv)"' >> ${shell_profile}

  OR manually add this to your shell's profile:
    eval "\$(~/Applications/homebrew/bin/brew shellenv)"
EOS
