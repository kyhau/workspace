
# Remove current installations, if any
sudo apt-get --purge remove node
# ("sudo apt autoremove node" if console is asking for)
sudo apt-get --purge remove nodejs

# Install node (e.g. version 10):
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt install node

# Then install build tools so you can install add-ons for npm later
sudo apt-get install -y build-essential

npm -v
node -v
