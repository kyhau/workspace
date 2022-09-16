#!/bin/bash

# TODO change key name
RSA_FILE=$HOME/.ssh/id_rsa_20190902
RSA_PUB_FILE="${RSA_FILE}.pub"


echo "================================================================================"
echo "Installing openssh-server..."
sudo apt install openssh-server

mkdir -p $HOME/.ssh/
chmod 0700 $HOME/.ssh/


function add_ssh_key() {
  rsa_file=$1
  if [[ -f ${rsa_file} ]]; then
    return
  fi

  echo "================================================================================"
  echo "Creating new ssh key..."
  ssh-keygen -t rsa -b 2048 -f ${RSA_FILE}

  ## [ warning this will overwrite existing file on the remote box ] ##
  # scp ${RSA_PUB_FILE} uname@myserver:~/.ssh/authorized_keys
  ## OR, copy or append locally available keys to authorise logins on a remote box
  # ssh-copy-id -i ${RSA_PUB_FILE} uname@myserver

  echo "================================================================================"
  echo "Updating ~/.base_profile"

  cat >> $HOME/.bash_profile <<EOL

###########################################################################
# allow $USER to use keys. Only enter once and it will remain enabled till
# you delete it or reboot the server
###########################################################################
/usr/bin/keychain ${RSA_FILE}
source $HOME/.keychain/$HOSTNAME-sh
EOL
}



add_ssh_key ${RSA_FILE}
