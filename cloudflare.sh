#!/bin/bash

cd /home/$USER/Downloads

#1- download the pkg from github
wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb

#2- extract & install the downloaded pkg
sudo dpkg -i cloudflared-linux-amd64.deb && sudo apt install -f && apt --fix-broken install

#4- sudo apt update && sudo apt upgrade
sudo apt update && sudo apt upgrade

#5- remove the downloaded pkg
rm -f cloudflared-linux-amd64.deb

cd

#6- warp-cli register && warp-cli connect
warp-cli register && warp-cli connect


#7- create your cloudflared tunnel
#cloudflared tunnel --url localhost:8080
