#!/bin/bash

run_commands() {
  echo "INFO: Running Snyk report"
  snyk monitor -d -insecure --all-projects --fail-fast --strict-out-of-sync=true --detection-depth=6
  snyk code test
}

echo "INFO: Run 'snyk auth' if needed"

for dir in $(find . -name .git -type d -prune); do
  repo_path=$(dirname $(readlink -f "$dir"))
  echo "INFO: Checking repo: ${repo_path}"
  cd ${repo_path}
  run_commands
  cd - 2>&1 >/dev/null
  echo "----------------------------------------"
  sleep 1
done