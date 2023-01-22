#!/bin/bash

UB(){
    # First, we will install the PPA in order to get access to its packages. From your home directory
    # making sure to replace 19.x with your preferred version string (if different).
    cd ~
    # Next, we will download the NodeSource setup script using curl.
    curl -sL https://deb.nodesource.com/setup_19.x -o /tmp/nodesource_setup.sh
    # Next, we will run the script as root to install the NodeSource repository.
    sudo bash /tmp/nodesource_setup.sh
    # Next, we will install Node.js and npm using apt.
    sudo apt install -y nodejs npm build-essential 
    echo
    # Next, we will verify the installation.
    node -v
}

RH(){
    sudo yum update
    # Add NodeSource yum repository   
    curl -sL https://rpm.nodesource.com/setup_19.x | sudo bash -
    # Install Node.js and npm
    sudo yum install -y nodejs npm
    echo
    # Next, we will verify the installation.
    node --version
}

if [ -f /etc/debian_version ]; then
    echo "Distro is Ubuntu or Debian"
    UB
elif [ -f /etc/redhat-release ]; then
    echo "Distro is CentOS or RHEL"
    RH
fi