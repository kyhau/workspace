#!/bin/bash
# Ref: https://stackoverflow.com/questions/598672/squash-the-first-two-commits-in-git

git rebase -i --root master

# Change pick to squash for those oldest commits

git push origin master --force