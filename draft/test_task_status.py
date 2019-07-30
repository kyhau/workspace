import boto3
import json

job_id = "5d55fc12-7cb1-4051-928f-a78064d2f162"


ret = boto3.resource("dynamodb").Table("OrcaJobs").get_item(Key={"job_id": job_id})
print(json.dumps(ret, indent=2))

task_id = ret["Item"]["task_id"]

ret = boto3.client("ecs").describe_tasks(
    cluster="Orca-Cluster",
    tasks=[task_id]
)

if ret["tasks"]:
    print(ret["tasks"][0]["lastStatus"])

    assert task_id == ret["tasks"][0]["taskArn"]
    assert ret["tasks"][0]["lastStatus"] ==  "STOPPED"
