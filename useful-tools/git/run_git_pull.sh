#!/bin/bash

run_git_commands() {
  git pull
  git -c diff.mnemonicprefix=false -c core.quotepath=false --no-optional-locks fetch --prune --tags origin
}

for dir in $(find . -name .git -type d -prune); do
  repo_path=$(dirname $(readlink -f "$dir"))
  echo "Checking repo: ${repo_path}"
  cd ${repo_path}
  run_git_commands
  cd - 2>&1 >/dev/null
  echo "----------------------------------------"
  sleep 1
done