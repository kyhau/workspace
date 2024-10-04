#!/bin/bash
set -e

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

if [[ -z "$1" ]]; then
  echo "Missing commit message"
else
  git commit -m "$1"
  git push --set-upstream origin $(git branch --show-current
  . ${SCRIPT_DIR}/git-auto-pr-merge.sh
fi
