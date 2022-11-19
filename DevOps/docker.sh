#!/bin/bash

UB(){
    # check if docker is already installed
    if (ls /bin | grep "docker" >/dev/null); then
        echo "Docker is already installed"
        read -p "Do you want to uninstall previous docker version? (y/n) " check_ans
        if [ "$check_ans" = "y" ]; then
            sudo apt-get remove docker docker-engine docker.io containerd runc
            sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-compose-plugin
            sudo apt-get autoremove --purge docker-ce docker-ce-cli containerd.io docker-compose-plugin
        else
            echo "skipping uninstallation of previous docker version"
            exit
        fi
    fi
    # 1. Set up the repository
    sudo apt-get update
    sudo apt-get install -y \
        ca-certificates \
        curl \
        gnupg \
        lsb-release

    sudo mkdir -p /etc/apt/keyrings
    sudo rm -f /etc/apt/keyrings/docker.gpg 
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    
    # add docker repository to apt source list
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    # 2. Install Docker Engine
    sudo apt-get update
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    sudo apt-get update

    # 3. Install Docker Engine, containerd, and Docker Compose.
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
}

RH(){
    # check if docker is already installed
    if (ls /bin | grep "docker" >/dev/null); then
        echo "Docker is already installed"
        read -p "Do you want to uninstall previous docker version? (y/n) " check_ans
        if [ "$check_ans" = "y" ]; then
            sudo yum remove docker \
                            docker-client \
                            docker-client-latest \
                            docker-common \
                            docker-latest \
                            docker-latest-logrotate \
                            docker-logrotate \
                            docker-engine
        else
            echo "skipping uninstallation of previous docker version"
            exit
        fi
    fi
    # 1. Set up the repository
    sudo yum install -y yum-utils
    sudo yum-config-manager \
        --add-repo \
        https://download.docker.com/linux/centos/docker-ce.repo

    # 2. Install Docker Engine
    sudo yum install docker-ce docker-ce-cli containerd.io docker-compose-plugi
}

if [ -f /etc/debian_version ]; then
    echo "Distro is Ubuntu or Debian"
    UB
elif [ -f /etc/redhat-release ]; then
    echo "Distro is CentOS or RHEL"
    RH
fi

clear 
echo "Docker engine and containerd installed"
echo "Restarting docker service"
echo
sleep 10
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl restart docker
clear
sleep 5
echo "Docker is now up & running :)"
echo "Try running 'docker ps' to check if it's working"
echo "if docker is still not running, please wait a couple of minutes and try the following command:"
echo "  sudo systemctl restart docker"
sudo usermod -aG docker $USER && newgrp docker  