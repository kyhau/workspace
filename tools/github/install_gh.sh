#!/bin/bash
# See also https://github.com/cli/cli/blob/trunk/docs/install_linux.md
set -e

if [ -x "$(command -v gh)" ]; then
  echo "INFO: $(gh --version)"
else
  echo "INFO: gh not installed"
fi

echo "INFO: Updating gh"
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y

echo "INFO: $(gh --version)"

# sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key C99B11DEB97541F0

# If seeing error
# ImportError: cannot import name '_gi' from partially initialized module 'gi' (most likely due to a circular import)
#sudo ln -s /usr/lib/python3/dist-packages/gi/_gi.cpython-{36m,37m,38}-x86_64-linux-gnu.so
#sudo apt-get install python3-pip
#sudo apt install libcairo2-dev -y
#sudo apt install libgirepository1.0-dev -y
#sudo python3.8 -m pip install --ignore-installed PyGObject

#sudo apt-add-repository https://cli.github.com/packages
