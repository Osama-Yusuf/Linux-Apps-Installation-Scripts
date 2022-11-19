#!/bin/bash

if [ -f /etc/debian_version ]; then
    echo "Distro is Ubuntu or Debian"
    PM="apt-get"
elif [ -f /etc/redhat-release ]; then
    echo "Distro is CentOS or RHEL"
    PM="yum"
fi

distro=$(cat /etc/os-release | grep "^ID=" | cut -d= -f2)
if [ $distro == "ubuntu" ] || [ $distro == "debian" ]; then
    echo "Distro is Ubuntu or Debian"
    PM="apt-get"
elif [ $distro == "centos" ] || [ $distro == "rhel" ]; then
    echo "Distro is CentOS or RHEL"
    PM="yum"
fi

sudo $PM install <app>