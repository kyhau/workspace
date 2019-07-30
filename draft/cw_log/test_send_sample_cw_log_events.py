import boto3
import time


NEXT_SEQUENCE_TOKEN = "49591428281805786324319252894354550626795982769505711602"
boto3.setup_default_session(profile_name="devops-testing")

LOG_GROUP_NAME = "API-Gateway-Execution-Logs_n9n4p4tvvb/v1"
LOG_STREAM_NAME = "17e62166fc8586dfa4d1bc0e1742c08b"

client = boto3.client("logs")


def send_sample_cloudwatch_loggroup_event(message, next_sequence_token):
  timestamp = int(round(time.time() * 1000))
  print(f"{message} : {timestamp}")

  resp = client.put_log_events(
    logGroupName=LOG_GROUP_NAME,
    logStreamName=LOG_STREAM_NAME,
    logEvents=[
      {
        "timestamp": timestamp,
        "message": message
      }
    ],
    sequenceToken=next_sequence_token
  )
  assert(resp["HTTPStatusCode"] == 200)
  print(resp)
  return resp["nextSequenceToken"]


if __name__ == "__main__":
  next_sequence_token = NEXT_SEQUENCE_TOKEN

  for i in range(20):
    next_sequence_token = send_sample_cloudwatch_loggroup_event(
      message=f"Simple Lambda Test {i}",
      next_sequence_token=next_sequence_token
    )

  print(f"Next Sequence Token: {next_sequence_token}")
