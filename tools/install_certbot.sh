#!/bin/bash
# https://certbot.eff.org/instructions

sudo apt update
sudo apt install snapd

sudo apt-get remove certbot

sudo snap install --classic certbot

#sudo certbot --apache
sudo certbot --nginx

sudo certbot renew --dry-run

# Check your website with https://www.ssllabs.com/ssltest/.
