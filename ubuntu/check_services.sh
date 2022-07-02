#!/bin/bash

if [[ $# -eq 0 ]] ; then
  echo "Usage: $0 SERVICE_NAME"
  exit 1
fi

SERVICE=$1

if [[ `lsb_release -c | grep focal` ]]; then
  ls /etc/init.d | grep ${SERVICE} | xargs -I "{}" sudo service "{}" status | grep " is "
else
  for i in $( ls /etc/init.d | grep ${SERVICE} ); do
    echo " *" $i is `sudo systemctl --no-pager status $i | grep "Active"`
  done
fi
