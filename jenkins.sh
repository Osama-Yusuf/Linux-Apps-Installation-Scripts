#!/bin/bash

# first we need to install java
sudo apt install -y openjdk-8-jdk
java version

sleep 2

# then we need to install maven
sudo apt install -y maven
mvn --version

sleep 2

# then we need to install git
sudo apt install -y git
git --version

sleep 2

# then we need to install curl
sudo apt install -y curl
curl --version

sleep 2

# lastly installing Jenkins
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install -y jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins

# opening the web browser and going to the jenkins url
firefox http://localhost:8080/



