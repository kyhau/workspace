OWNER="kyhau"
REPO="workspaces"

gh api -X GET /repos/$OWNER/$REPO/actions/workflows | jq '.workflows[] | .name,.id'

WORKFLOW_ID="TODO"

runs=`gh api -X GET /repos/$OWNER/$REPO/actions/workflows/$WORKFLOW_ID/runs --paginate | jq '.workflow_runs[] | .id'`

for r in $runs;
do
  gh api -X DELETE /repos/$OWNER/$REPO/actions/runs/$r
done
