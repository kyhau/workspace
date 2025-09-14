#!/bin/bash
set -e

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

if [[ -z "$1" ]] || [[ -z "$2" ]] ; then
  echo "Arguments: [BRANCH_NAME] [COMMIT_MESSAGE]"
else
  . ${SCRIPT_DIR}/git-auto-branch.sh "$1"
  git add .
  . ${SCRIPT_DIR}/git-auto-commit-pr-merge.sh "$2"
fi

exit 0
