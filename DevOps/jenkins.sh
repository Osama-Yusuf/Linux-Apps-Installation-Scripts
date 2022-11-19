#!/bin/bash

ask_before_uninstall() {
    read -p "Do you want to uninstall jenkins? (y/n) " check_ans
    if [ "$check_ans" = "y" ]; then
        sudo apt-get remove -y jenkins
        sudo apt-get purge -y jenkins
        clear
        echo "Previous jenkins version uninstalled"
        echo
        sleep 2
    elif [ "$check_ans" = "n" ]; then
        clear
        echo "skipping uninstallation of previous jenkins version"
        exit
    else
        clear
        echo "Invalid input, Please enter y or n"
        ask_before_uninstall
    fi
}

install_jenkins() {
    # first we need to install java
    sudo apt install -y openjdk-8-jdk
    # add JAVA_HOME to /etc/environment file for jenkins to work
    echo 'JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"' | sudo tee -a /etc/environment
    # reload environment variables
    source /etc/environment
    # check if JAVA_HOME is set with "echo $JAVA_HOME"
    clear
    java -version
    echo
    echo "Java is installed & configured"
    echo
    sleep 2

    # then we need to install maven
    sudo apt install -y maven
    clear
    mvn --version
    echo
    echo "Maven is installed"
    echo
    sleep 2

    # then we need to install git
    sudo apt install -y git
    clear
    git --version
    echo "Git is installed"
    echo
    sleep 2

    # then we need to install curl
    sudo apt install -y curl
    clear
    echo
    curl --version
    echo "Curl is installed"
    echo
    sleep 1

    clear 
    echo "Jenkins Dependencies are installed"
    echo
    echo "Installing Jenkins"
    echo
    sleep 2

    # lastly installing Jenkins
    sudo rm -f /usr/share/keyrings/jenkins.gpg
    wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo gpg --dearmor -o /usr/share/keyrings/jenkins.gpg
    sudo sh -c 'echo deb [signed-by=/usr/share/keyrings/jenkins.gpg] http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
    sudo apt update
    sudo apt install jenkins

    # append java path to jenkins service
    echo PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/lib/jvm/java-8-openjdk-amd64/bin/ >> /etc/init.d/jenkins

    sudo systemctl start jenkins.service

    clear 

    echo "Jenkins is now up & running :)"
    echo 
    echo "You can check it's state with the following command:"
    echo "sudo systemctl status jenkins"
    echo 
    echo "opening the web browser open the jenkins url"
    echo "http://<ip>:8080/ or http://localhost:8080/"
}

# check if jenkins installed
check_jenkins() {
    if [ -x "$(command -v jenkins)" ]; then
        echo "jenkins is already installed"
        echo
        ask_before_uninstall
        install_jenkins
    else
        install_jenkins
    fi
}
check_jenkins
