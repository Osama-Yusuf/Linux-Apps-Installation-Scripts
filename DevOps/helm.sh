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

install_helm() {
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    # if get_helm.sh is not in the current directory, then exit else execute the script
    if [ ! -f get_helm.sh ]; then
        echo "get_helm.sh not downloaded check your internet or the directory where it's downloaded"
        exit 1
    else
        chmod +x get_helm.sh
        ./get_helm.sh
        rm -f get_helm.sh
    fi
}

# check if helm installed 
check_helm() {
    if [ -x "$(command -v helm)" ]; then
        echo "helm is already installed"
        echo
        ask_before_uninstall
        install_helm
    else
        install_helm
    fi
}
check_helm 