#!/bin/bash

check_docker() {
    if (ls /bin | grep "docker" >/dev/null); then
        # echo "Good, docker is installed lets's move on to the next step"
        echo >/dev/null
    else
        read -p "docker is not installed, would you like to install it? [y/n] " install_docker
        if [ "$install_docker" = "y" ]; then
            source <(curl -s https://raw.githubusercontent.com/Osama-Yusuf/Linux-Apps-Installation-Scripts/main/DevOps/docker.sh)
        elif [ "$install_docker" = "n" ]; then
            echo "Please install docker and try again"
            exit 1
        else
            echo "Invalid input, Please enter y or n"
            check_docker
        fi
    fi
}
check_docker 
read -p "Enter port number you want to create for the rancher server: " rancher_port
sudo docker run -d --restart=unless-stopped -p $rancher_port:8080 rancher/server:stable

# 127.0.0.1:8080