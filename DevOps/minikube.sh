#!/bin/bash

if [ -x "$(command -v minikube)" ]; then
    echo "minikube is already installed"
    read -p "Do you want to uninstall minikube? (y/n) " check_ans
    if [ "$check_ans" = "y" ]; then
        minikube stop; minikube delete
        docker stop 
        rm -r ~/.kube ~/.minikube
        sudo rm /usr/local/bin/localkube /usr/local/bin/minikube
        systemctl stop '*kubelet*.mount'
        sudo rm -rf /etc/kubernetes/
        docker system prune -af --volumes
        clear
        echo "Previous minikube version uninstalled"
        echo
    else
        echo "skipping uninstallation of previous minikube version"
        exit
    fi
fi

# check if docker is not installed
if !(ls /bin | grep "docker" >/dev/null); then
    echo "Docker is not installed"
    read -p "Do you want to install docker? (y/n) " check_ans
    if [ "$check_ans" = "y" ]; then
        source <(curl -s https://raw.githubusercontent.com/Osama-Yusuf/Linux-Apps-Installation-Scripts/main/DevOps/docker.sh)
    else
        echo "You need to install docker first"
        exit
    if
fi


UB(){
    sudo apt update -y && sudo apt upgrade -y
    sudo apt install curl -y
    sudo apt install virtualbox virtualbox-ext-pack -y
    wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    sudo cp minikube-linux-amd64 /usr/local/bin/minikube
    sudo chmod 755 /usr/local/bin/minikube
    sudo rm minikube-linux-amd64
}

RH(){
    sudo yum update -y && sudo yum upgrade -y
    sudo yum install curl -y
    sudo curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-latest.x86_64.rpm && sudo rpm -Uvh minikube-latest.x86_64.rpm
    sudo rm -fr minikube-latest.x86_64.rpm
}

if [ -f /etc/debian_version ]; then
    # Check Ubuntu or Debian
    echo "Distro is Ubuntu or Debian"
    UB
elif [ -f /etc/redhat-release ]; then
    # Check CentOS or Red Hat Enterprise Linux
    echo "Distro is CentOS or RHEL"
    RH
fi

minikube version
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
sudo chmod +x kubectl
sudo mv kubectl /usr/local/bin/
minikube start