#!/bin/bash
set -e

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

ORI_BRANCH=$(git branch --show-current)
gh pr create --assignee @me --fill
gh pr merge --squash --admin
git checkout $(gh repo view --json defaultBranchRef --jq .defaultBranchRef.name)

. ${SCRIPT_DIR}/run_git_pull.sh

git branch -D ${ORI_BRANCH}
