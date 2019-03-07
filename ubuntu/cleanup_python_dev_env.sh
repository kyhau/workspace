#!/bin/bash

#echo "Folder size: $(du -sh)" .

declare -a FOLDERS=(
  ".tox"
  "*.egg-info"
  "__pycache__"
  "env"
  "env_*"
)
declare -a FILES=(
  ".coverage"
  "coverage_py*.xml"
  "junit-py*.xml"
)

delete_stuff() {
  local option=${1}
  shift
  local targets=("$@")
  for target in "${targets[@]}"
  do
    echo "Finding $target in current directory"
    for item in $(find -name "${target}" -type ${option})
    do
      echo "Removing ${item}"
      rm -rf ${item}
    done
  done
}

delete_stuff "d" "${FOLDERS[@]}"
delete_stuff "f" "${FILES[@]}"

#echo "Folder size: $(du -sh)" .
