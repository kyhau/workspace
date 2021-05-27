#!/bin/bash

run_git_commands() {
  git branch
}

for dir in $(find . -name .git -type d -prune); do
  repo_path=$(dirname $(readlink -f "$dir"))
  echo "Checking repo: ${repo_path}"
  cd ${repo_path}
  run_git_commands
  cd - 2>&1 >/dev/null
  echo "----------------------------------------"
done