#!/bin/bash

#echo "Folder size: $(du -sh)" .

# declare an array variable
declare -a TARGETS=(
  ".tox"
  "*.egg-info"
  "__pycache__"
  ".coverage"
  "coverage_py*.xml"
  "junit-py*.xml"
)

## now loop through the above array
for target in "${TARGETS[@]}"
do
  echo "Finding $target in current directory"
  for item in $(find -name "${target}")
  do
    echo "Removing ${item}"
    rm -rf ${item}
  done
done

#echo "Folder size: $(du -sh)" .
