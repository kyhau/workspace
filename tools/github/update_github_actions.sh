#!/bin/bash

ACTION_NAME="actions/checkout"
FROM_VERSION="v2"
TO_VERSION="v3"

run_commands() {
  echo "INFO: Finding ${ACTION_NAME}"
  egrep -ir --include=*.{yaml,yml} "${ACTION_NAME}" .

  for f in $(egrep -ir --include=*.{yaml,yml} "${ACTION_NAME}" . | grep -v "${TO_VERSION}" | awk -F ':' '{print $1}'); do
    echo "INFO: Updating $f"
    sed -i 's/checkout\@v2/checkout\@v3/g' ${f}
  done
}

for dir in $(find . -name .github -type d -prune); do
  repo_path=$(dirname $(readlink -f "$dir"))
  echo "INFO: Checking repo: ${repo_path}"
  cd ${repo_path}
  run_commands
  cd - 2>&1 >/dev/null
  echo "----------------------------------------"
  sleep 1
done
