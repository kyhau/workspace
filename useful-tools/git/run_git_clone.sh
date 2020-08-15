#!/bin/bash

declare -a arr=(
  "xxx"
)

for i in "${arr[@]}"
do
    git clone $i
done
