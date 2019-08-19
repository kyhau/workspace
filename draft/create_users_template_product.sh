#!/bin/bash

# Simple script just to generate the initial template, which all users are assigned to the same groups.

OUTPUT_FILE=tmp_product_users.template

declare -a USERS=(
  "Firstname Lastname"
)

# Add Header
cat > ${OUTPUT_FILE} << EOF
AWSTemplateFormatVersion: '2010-09-09'
Description: >-
  Create IAM Users and assign users to the corresponding IAM Groups at biarri-networks-product.

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
        - BN-Orca-PullECR
  ${name_no_space}IamAccessKey:
    DependsOn: ${name_no_space}IamUser
    Type: AWS::IAM::AccessKey
    Properties:
      UserName: ${user_name}

EOF
done

# Add Outputs

echo "Outputs:" >> ${OUTPUT_FILE}

for user in "${USERS[@]}"
do
  name_no_space=${user//[ ]/}
  user_name=`echo "print('${user//[ ]/.}'.lower())" | python`

cat >> ${OUTPUT_FILE} << EOF
  ${name_no_space}IamAccessKeyId:
    Value: !Ref ${name_no_space}IamAccessKey
  ${name_no_space}IamSecretAccessKey:
    Value: !GetAtt ${name_no_space}IamAccessKey.SecretAccessKey

EOF
done
