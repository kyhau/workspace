#!/bin/bash
set -e

# See https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu
# See https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-install-script

sudo apt-get update && sudo apt-get install -y dotnet-sdk-7.0
