#!/bin/bash

# TODO Then update the following 3 values
GroupName="ATT"
VmNamePrefix="att.si"
Nums=( "01" "02" "03" "04" "05" "06" "07" "08" "09" )

for i in "${Nums[@]}"
do
  vmName="${VmNamePrefix}.${i}"

  # use openssl to generate a random string, keep only all letters and digits "[:alnum:]"
  # return the first 10 chars
  pw=`openssl rand -base64 20 | tr -cd '[[:alnum:]]._-' | head -c10`

  echo "Adding ${vmName} ${pw} to users_raw.csv"

  echo "${vmName},${pw},${GroupName}" >> config/users_raw.csv

done
