#!/bin/bash

# wscat -c wss://4l8cex8wnj.execute-api.ap-southeast-2.amazonaws.com/dev
# Type in one terminal {"action":"sendmessage", "data":"hello world 2"}

for ((i=0;i<1;i++)); do
  timestamp=$(($(date +%s%N)/1000000))
  echo "Message $i Timestamp : $timestamp"

  ret=$(aws logs put-log-events --log-group-name API-Gateway-Execution-Logs_n9n4p4tvvb/v1 \
    --profile devops-testing \
    --log-stream-name 17e62166fc8586dfa4d1bc0e1742c08b \
    --log-events "[{\"timestamp\":${timestamp} , \"message\": \"Simple Lambda Test ${i}\"}]" \
    --sequence-token 49591428281805786324319249872719417900846165990467188210
  )
  echo $ret
done


