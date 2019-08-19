#!/bin/bash

# Simple script just to generate the initial template, which all users are assigned to the same groups.

OUTPUT_FILE=tmp_networks_users.template

declare -a USERS=(
  "Firstname Lastname"
)


# Add Header
cat > ${OUTPUT_FILE} << EOF
AWSTemplateFormatVersion: '2010-09-09'
Description: >-
  Create IAM Users and assign users to the corresponding IAM Groups at biarri-networks.

Resources:
EOF

# Add Resources
for user in "${USERS[@]}"
do
  echo "Adding $user"
  name_no_space=${user//[ ]/}
  user_name=`echo "print('${user//[ ]/.}'.lower())" | python`

cat >> ${OUTPUT_FILE} << EOF
  ${name_no_space}IamUser:
    Type: AWS::IAM::User
    Properties:
      UserName: ${user_name}
      Groups:
        - BN-ConsoleUsers
        - BN-Developers
        - BN-DEV-FOND

EOF
done
