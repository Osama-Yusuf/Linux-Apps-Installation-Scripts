#!/bin/bash
UB(){
    #1- download the pkg from github
    wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb

    #2- extract & install the downloaded pkg
    sudo dpkg -i cloudflared-linux-amd64.deb && sudo apt install -f && apt --fix-broken install

    #4- sudo apt update && sudo apt upgrade
    sudo apt update && sudo apt upgrade

    #5- remove the downloaded pkg
    rm -f cloudflared-linux-amd64.deb

    #6- warp-cli register && warp-cli connect
    warp-cli register && warp-cli connect

    #7- create your cloudflared tunnel
    #cloudflared tunnel --url localhost:8080
}

RH(){
    wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-x86_64.rpm
    rpm -Uvh cloudflared-linux-x86_64.rpm
    rm -f cloudflared-linux-x86_64.rpm
    echo "Example:"
    echo "cloudflared tunnel --url http://localhost:8081/"
}

if [ -f /etc/debian_version ]; then
    echo "Distro is Ubuntu or Debian"
    UB
elif [ -f /etc/redhat-release ]; then
    echo "Distro is CentOS or RHEL"
    RH
fi