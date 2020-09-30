
$ gh alias set pv 'pr view'
# gh pv -w 123
# => gh pr view -w 123

gh alias set bugs 'issue list --label="bugs"'

gh alias set epicsBy 'issue list --author="$1" --label="epic"'
# e.g. gh epicsBy vilmibm

gh alias set --shell igrep 'gh issue list --label="$1" | grep $2'
# gh igrep epic foo
# => gh issue list --label="epic" | grep "foo"
