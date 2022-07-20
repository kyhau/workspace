#!/bin/bash
# Ref: https://stackoverflow.com/questions/1657017/how-to-squash-all-git-commits-into-one/1670828#1670828

# You can simply create a new orphan branch at the tip (i.e. the most recent commit) of your current branch.
# This orphan branch forms the initial root commit of an entirely new and separate commit history tree,
# which is effectively equivalent to squashing all of your commits:

git checkout --orphan new-main main
git commit -m "A new start"
git branch -M new-main main
git push origin main --force
