#!/bin/bash

ask_before_uninstall() {
    read -p "Do you want to uninstall helm? (y/n) " check_ans
    if [ "$check_ans" = "y" ]; then
        sudo rm -f /usr/local/bin/helm
        clear
        echo "Previous helm version uninstalled"
        echo
    elif [ "$check_ans" = "n" ]; then
        clear
        echo "skipping uninstallation of previous helm version"
        exit
    else
        clear
        echo "Invalid input, Please enter y or n"
        ask_before_uninstall
    fi
}

UB(){
# ------------------------------- first method ------------------------------- #
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm
# ------------------------------- second method ------------------------------- #
# curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
# chmod 700 get_helm.sh
# ./get_helm.sh
# ------------------------------ Easisest method ----------------------------- #
# sudo snap install helm --classic
}

RH(){
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh
    rm -f get_helm.sh
}

distro(){
    if [ -f /etc/debian_version ]; then
        echo "Distro is Ubuntu or Debian"
        UB
    elif [ -f /etc/redhat-release ]; then
        echo "Distro is CentOS or RHEL"
        RH
    fi
}

# check if helm installed 
check_helm() {
    if [ -x "$(command -v helm)" ]; then
        echo "helm is already installed"
        echo
        ask_before_uninstall
        distro
    else
        distro
    fi
}
check_helm