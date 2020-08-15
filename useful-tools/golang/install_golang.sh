#!/bin/bash

# https://github.com/golang/go/wiki/Ubuntu

sudo apt update && sudo apt-get install -y \
  software-properties-common

# If have issue
# edit first line of /usr/bin/add-apt-repository to use #!/usr/bin/python3.6

sudo add-apt-repository -y ppa:longsleep/golang-backports

sudo apt update && sudo apt-get install -y golang-go
sudo apt -y autoremove

go run test1.go
