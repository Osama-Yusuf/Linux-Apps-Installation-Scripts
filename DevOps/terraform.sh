#!/bin/bash
UB(){
    # 1. Ensure  system is up to date, and you have the gnupg, software-properties-common, and curl packages 
    sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl wget

    # 2. Add the HashiCorp GPG key.
    wget -O- https://apt.releases.hashicorp.com/gpg | \
        gpg --dearmor | \
        sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

    # 3. Verify the key's fingerprint.
    gpg --no-default-keyring \
        --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
        --fingerprint

    # 4. Add the official HashiCorp Linux repository.
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
        https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
        sudo tee /etc/apt/sources.list.d/hashicorp.list
    
    # 5. Update and install.
    sudo apt update
    sudo apt-get install terraform -y
}

RH(){
    # 1. Install yum-config-manager to manage your repositories.
    sudo yum install -y yum-utils
    # 2. Use yum-config-manager to add the official HashiCorp Linux repository.
    sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
    # 3. Install Terraform.
    sudo yum -y install terraform
    # 4. Verify the installation.
    terraform -help
}

if [ -f /etc/debian_version ]; then
    echo "Distro is Ubuntu or Debian"
    UB
elif [ -f /etc/redhat-release ]; then
    echo "Distro is CentOS or RHEL"
    RH
fi