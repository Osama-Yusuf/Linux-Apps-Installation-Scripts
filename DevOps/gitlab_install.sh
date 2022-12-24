#!/bin/bash

read -p "Enter the external URL for GitLab: " EXTERNAL_URL

RH(){
    sudo yum upgrade 
    sudo yum update

    # 1. Install and configure the necessary dependencies
    sudo yum install -y curl policycoreutils-python openssh-server perl
    # Enable OpenSSH server daemon if not enabled: sudo systemctl status sshd
    sudo systemctl enable sshd
    sudo systemctl start sshd
    
    # Check if opening the firewall is needed with: sudo systemctl status firewalld
    sudo firewall-cmd --permanent --add-service=http
    sudo firewall-cmd --permanent --add-service=https
    sudo systemctl reload firewalld

    # --- Next, install Postfix (or Sendmail) to send notification emails
    # sudo yum install postfix
    # sudo systemctl enable postfix
    # sudo systemctl start postfix

    # 2. Add the GitLab package repository and install the package
    curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.rpm.sh | sudo bash
    sudo yum upgrade -y && sudo yum update -y

    # sudo yum install -y gitlab-ee
    sudo EXTERNAL_URL="http://$EXTERNAL_URL:80" yum install -y gitlab-ee
    gitlab-ctl restart
    gitlab-ctl reconfigure

    # 3. install gitlab-runner
    curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.rpm.sh" | sudo bash
    sudo yum install gitlab-runner
    yum list gitlab-runner --showduplicates | sort -r
    sudo yum install gitlab-runner-10.0.0-1
    sudo yum update
    sudo yum install gitlab-runner
}

UB(){
    # 1. Install and configure the necessary dependencies
    sudo apt-get update && sudo apt-get upgrade -y
    sudo apt-get install -y curl openssh-server ca-certificates tzdata perl

    # --- Next, install Postfix (or Sendmail) to send notification emails
    # sudo apt-get install -y postfix

    # 2. Add the GitLab package repository and install the package
    curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash

    sudo apt update -y && sudo apt upgrade -y

    # Next, install the GitLab package.
    sudo EXTERNAL_URL="http://$EXTERNAL_URL:80" apt install -y gitlab-ee

    gitlab-ctl restart
    gitlab-ctl reconfigure

    # 3. install gitlab-runner
    curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | sudo bash
    sudo apt-get install gitlab-runner
    apt-cache madison gitlab-runner
    sudo apt-get install gitlab-runner=10.0.0
    sudo apt-get update
    sudo apt-get install gitlab-runner
}

if [ -f /etc/debian_version ]; then
    echo "Distro is Ubuntu or Debian"
    UB
elif [ -f /etc/redhat-release ]; then
    echo "Distro is CentOS or RHEL"
    RH
fi

username="User: root"
password=$(sudo cat /etc/gitlab/initial_root_password | grep Password:)
echo -e "\nopen http://$EXTERNAL_URL in your browser and login with the following credentials:"
echo -e "\n$username\n$password"
sleep 5

read -p "Enter Registration Token from GitLab server(CI/CD settings): " REG_TOKEN

sudo gitlab-runner register -n \
  --url "http://$EXTERNAL_URL" \
  --registration-token $REG_TOKEN \
  --executor docker \
  --description "My Docker Runner" \
  --docker-image "docker:20.10.16" \
  --docker-volumes /var/run/docker.sock:/var/run/docker.sock

# sudo gitlab-runner register

echo """gitlab registry by default is disabled, to enable it do the following: 
1. edit with sudo vim /etc/gitlab/gitlab.rb and search for 'registry_external_url' and uncomment it
2. sudo gitlab-ctl reconfigure"""

# ---- If you are behind a proxy, add an environment variable and then run the registration command:
# export HTTP_PROXY=http://yourproxyurl:3128
# export HTTPS_PROXY=http://yourproxyurl:3128
# sudo -E gitlab-runner register

# ---- To get runner configs
# code /etc/gitlab-runner/config.toml