#!/bin/bash
UB(){
    sudo apt update -y && sudo apt upgrade -y
    sudo apt install wget -y
    wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -
    echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list
    sudo apt update
    sudo apt install anydesk -y
    anydesk
}
RH(){
    cat > /etc/yum.repos.d/AnyDesk-CentOS.repo << "EOF"
[anydesk]

name=AnyDesk CentOS - stable

baseurl="http://rpm.anydesk.com/centos/$basearch/"

gpgcheck=1

repo_gpgcheck=1

gpgkey=https://keys.anydesk.com/repos/RPM-GPG-KEY

EOF
    sudo yum update
    sudo yum makecache
    sudo yum install -y redhat-lsb-core
    sudo yum install -y anydesk
    rpm -qi anydesk
    anydesk
    # https://linuxways.net/centos/how-to-install-anydesk-on-centos-8/
}
if [ -f /etc/debian_version ]; then
    echo "Distro is Ubuntu or Debian"
    UB
elif [ -f /etc/redhat-release ]; then
    echo "Distro is CentOS or RHEL"
    RH
fi