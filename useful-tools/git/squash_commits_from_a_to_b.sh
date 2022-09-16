#!/bin/bash
# Ref: https://stackoverflow.com/questions/56262651/git-squash-older-commits-not-last-one/56262851

# (where n is how far do you want to go back in history)
git rebase -i HEAD~n

# Change pick to squash for those oldest commits
git push origin main --force
