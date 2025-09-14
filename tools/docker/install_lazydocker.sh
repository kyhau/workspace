#!/bin/bash
# Install lazydocker https://github.com/jesseduffield/lazydocker
set -e

if [ -x "$(command -v lazydocker)" ]; then
  echo "INFO: lazydocker version: $(lazydocker --version | grep 'Version' | awk -F' ' '{print $2}')"
else
  echo "INFO: lazydocker not installed"
fi

echo "INFO: Installing lazydocker to $HOME/.local/bin"
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

echo "INFO: lazydocker version: $(lazydocker --version | grep 'Version' | awk -F' ' '{print $2}')"

echo "INFO: Config location: ~/.config/jesseduffield/lazydocker/config.yml"
# Config Locations:
#   OSX: ~/Library/Application Support/jesseduffield/lazydocker/config.yml
#   Linux: ~/.config/jesseduffield/lazydocker/config.yml
#   Windows: C:\\Users\\<User>\\AppData\\Roaming\\jesseduffield\\lazydocker\\config.yml
