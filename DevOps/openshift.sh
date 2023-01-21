#!/bin/bash

echo "System requirements:"
echo " 4 CPU"
echo " 10 GB RAM"
echo " 50 GB Disk"
echo " virtualization enabled"

UB(){
    sudo apt install qemu-kvm libvirt-daemon libvirt-daemon-system network-manager
    sudo apt-get install wget
    wget https://mirror.openshift.com/pub/openshift-v4/clients/crc/latest/crc-linux-amd64.tar.xz
    sudo tar -xpvf crc-linux-amd64.tar.xz
    rm -fr crc-linux-amd64.tar.xz
    cd crc-linux-*
    sudo cp crc /usr/local/bin/
    crc version
    echo "Openshift installed successfully"
}

RH(){
    su -c 'yum install NetworkManager'
    sudo yum install wget
    wget https://mirror.openshift.com/pub/openshift-v4/clients/crc/latest/crc-linux-amd64.tar.xz
    sudo tar -xpvf crc-linux-amd64.tar.xz
    rm -fr crc-linux-amd64.tar.xz
    cd crc-linux-*
    sudo cp crc /usr/local/bin/
    echo --------------------------------
    crc version
    echo "Openshift installed successfully"
}

if [ -f /etc/debian_version ]; then
    echo "Distro is Ubuntu or Debian"
    UB
elif [ -f /etc/redhat-release ]; then
    echo "Distro is CentOS or RHEL"
    RH
fi
cd .. && rm -fr crc-linux-*
crc setup

