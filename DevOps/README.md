# DevOps Tools Installation Scripts

## Tools

- [**Docker**](#docker-installation)
- [**GitLab**](#gitlab-installation)
- [**Helm**](#helm-installation)
- [**Jenkins**](#jenkins-installation)
- [**Minikube**](#minikube)
- [**OpenShift**](#openshift)
- [**Rancher**](#rancher)
- [**Ansible**](#ansible)
- [**Terraform**](#terraform)
- [**AWS CLI V2**](#aws-cli-v2)

## You can execute the script directly without downloading it:

```
bash <(curl -s https://raw.githubusercontent.com/Osama-Yusuf/Linux-Apps-Installation-Scripts/main/devops/<app_name>.sh)
```

## Or you can download it on your device, give it execution permissions & execute it:

```
curl "https://raw.githubusercontent.com/Osama-Yusuf/Linux-Apps-Installation-Scripts/main/devops/<app_name>.sh" -o <app_name>.sh && chmod +x <app_name>.sh && ./<app_name>.sh
```

## The following links will execute scripts without downloading them:
---
## Docker Installation

```
source <(curl -s https://raw.githubusercontent.com/Osama-Yusuf/Linux-Apps-Installation-Scripts/main/DevOps/docker.sh)
```
### for auto completion:
<br/>

##### On CentOS/RedHat:
```
yum install bash-completion -y
```
##### On Ubuntu/Debian:
```
apt-get install bash-completion -y
```

## GitLab Installation

```
source <(curl -s https://raw.githubusercontent.com/Osama-Yusuf/Linux-Apps-Installation-Scripts/main/DevOps/gitlab_install.sh)
```

## Helm Installation
(1) From the official "get_helm.sh" script
```
source <(curl -s https://raw.githubusercontent.com/Osama-Yusuf/Linux-Apps-Installation-Scripts/main/DevOps/helm.sh)
```
(2) With apt-get
```
source <(curl -s https://raw.githubusercontent.com/Osama-Yusuf/Linux-Apps-Installation-Scripts/main/DevOps/helm-apt.sh)
```
(3) With snap
```
sudo snap install helm --classic
```

## Jenkins Installation

```
source <(curl -s https://raw.githubusercontent.com/Osama-Yusuf/Linux-Apps-Installation-Scripts/main/DevOps/jenkins.sh)
```

### You can run jenkins as a docker container.

```
docker run -d --name jenkins -p 8080:8080 --restart=on-failure -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts-jdk11
```

#### This will automatically create a 'jenkins_home' docker volume on the host machine. Docker volumes retain their content even when the container is stopped, started, or deleted.

### ---

### Now get inside jenkins container & change the password of the admin user.

```
docker ps
```
```
docker exec -it <jenkins_container_id> /bin/bash
```
```
cat /var/jenkins_home/secrets/initialAdminPassword
```

### ------------------------------


## Minikube

```
source <(curl -s https://raw.githubusercontent.com/Osama-Yusuf/Linux-Apps-Installation-Scripts/main/DevOps/minikube.sh)
```

## OpenShift

```
source <(curl -s https://raw.githubusercontent.com/Osama-Yusuf/Linux-Apps-Installation-Scripts/main/DevOps/openshift.sh)
```

## Rancher

```
source <(curl -s https://raw.githubusercontent.com/Osama-Yusuf/Linux-Apps-Installation-Scripts/main/DevOps/rancher.sh)
```

## Ansible
```
sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible
```
for further details, visit:
```
https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-ansible-on-ubuntu-20-04
```

## Terraform

```
source <(curl -s https://raw.githubusercontent.com/Osama-Yusuf/Linux-Apps-Installation-Scripts/main/DevOps/terraform.sh)
```

# AWS CLI v2

This bundle contains a built executable of the AWS CLI v2.

## Installation

Download the latest installation script:
```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip
```
To install the AWS CLI v2, run the `install` script:
```
sudo ./aws/install && rm -rf aws awscliv2.zip
```
This will install the AWS CLI v2 at `/usr/local/bin/aws`.  Assuming
`/usr/local/bin` is on your `PATH`, you can now run:
```
aws --version
```


### Installing without sudo

If you don't have ``sudo`` permissions or want to install the AWS
CLI v2 only for the current user, run the `install` script with the `-b`
and `-i` options:
```
./install -i ~/.local/aws-cli -b ~/.local/bin
``` 
This will install the AWS CLI v2 in `~/.local/aws-cli` and create
symlinks for `aws` and `aws_completer` in `~/.local/bin`. For more
information about these options, run the `install` script with `-h`:
```
./install -h
```

### Updating

If you run the `install` script and there is a previously installed version
of the AWS CLI v2, the script will error out. To update to the version included
in this bundle, run the `install` script with `--update`:
```
sudo ./install --update
```


### Removing the installation

To remove the AWS CLI v2, delete the its installation and symlinks:
```
sudo rm -rf /usr/local/aws-cli
sudo rm /usr/local/bin/aws
sudo rm /usr/local/bin/aws_completer
```
Note if you installed the AWS CLI v2 using the `-b` or `-i` options, you will
need to remove the installation and the symlinks in the directories you
specified.
