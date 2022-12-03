# Bash scripts to automate iterative tasks  

## Scripts

- [**Docker Images and Containers Cleaner**](#docker-images-and-containers-cleaner)
- [**Kubernetes CLI auto-completion**](#kubernetes-cli-auto-completion)
- [**AWS EC2 Status Controller**](#aws-ec2-status-controller)
- [**Fav Bash Aliases**](#fav-bash-aliases)
- [**MyIP**](#myip)
- [**AWS Console**](#aws-console)
- [**WIfi Passwords**](#wifi-passwords)

## You can execute the script directly without downloading it:

```
bash <(curl -s https://raw.githubusercontent.com/Osama-Yusuf/Linux-Apps-Installation-Scripts/main/DevOps/Automations.sh/<app_name>.sh)
```

## Or you can download it on your device, give it execution permissions & execute it:

```
curl "https://raw.githubusercontent.com/Osama-Yusuf/Linux-Apps-Installation-Scripts/main/DevOps/Automations.sh/<app_name>.sh" -o <app_name>.sh && chmod +x <app_name>.sh && ./<app_name>.sh
```

## The following links will execute scripts without downloading them:
----

- ## Docker Images and Containers Cleaner
  Removes all none images & none containers and can be extended to do more with args.

  ### Install
  ```
  curl "https://raw.githubusercontent.com/Osama-Yusuf/Linux-Apps-Installation-Scripts/main/DevOps/Automations.sh/clean_docker.sh" -o clean_docker.sh && chmod +x clean_docker.sh
  ```

  ### Usage
  ```
  ./clean_none.sh [OPTION]
    -l, --last      remove last image created
    -i, --image     remove specific image by id
    -e, --exited    remove all exited containers
    -c, --container remove specific container by id
    -h, --help      display this help and exit
  ```

- ## AWS EC2 Status Controller 
  This script scans, saves and starts/stops/terminates instances in AWS.

  ### Install
  ```
  curl "https://raw.githubusercontent.com/Osama-Yusuf/Linux-Apps-Installation-Scripts/main/DevOps/Automations.sh/aws_ec2.sh" -o aws_ec2.sh && chmod +x aws_ec2.sh
  ```

  ### Usage
  ```
  1. bash aws_ec2.sh scan save
  2. bash aws_ec2.sh check [region]
  3. bash aws_ec2.sh [start|stop|terminate|ip] [region] [instance_id]

  ./aws_ec2.sh
          scan                                scans all regions and saves only scan result in $rgs_dir/scan
          scan save                           scans and saves the instances ids for further use in $rgs_dir

          regions                             lists all saved regions, but you must first scan and save the instances
          [region]                            print info about instances inside passed region

          [command] [region] [instance_id]    [start|stop|terminate|ip|check] but you must first scan and save the instances

  Eg: ./aws_ec2.sh start us-east-1                         starts all instances in us-east-1
  Eg: ./aws_ec2.sh start us-east-1 i-050b7d36ad76bddea     starts a specific instance in us-east-1
  ```

- ## AWS Console
  Opens AWS console in your browser with your credentials.

  ### Install
  ```
  curl "https://raw.githubusercontent.com/Osama-Yusuf/Linux-Apps-Installation-Scripts/main/DevOps/Automations.sh/aws-console.sh" -o aws-console.sh && chmod +x aws-console.sh
  ```

  ### Usage
  ```
   ./aws-console.sh [Browser] [Profile]
  ```

- ## Kubernetes CLI auto-completion

  ```
  source <(curl -s https://raw.githubusercontent.com/Osama-Yusuf/Linux-Apps-Installation-Scripts/main/DevOps/Automations.sh/k8s_autocompelete.sh)
  ```

- ## Fav Bash Aliases
    Adds more aliases (ls -alf=ll, clear=c, python3=py, kubectl=kl, myip) to the ~/.bashrc file

  ```
  source <(curl -s https://raw.githubusercontent.com/Osama-Yusuf/Linux-Apps-Installation-Scripts/main/DevOps/Automations.sh/alias.sh)
  ```

- ## MyIP

  ```
  hostname -I | awk '{print $1}'
  ```

- ## WIfi Passwords

  ```
  source <(curl -s https://raw.githubusercontent.com/Osama-Yusuf/Linux-Apps-Installation-Scripts/main/DevOps/Automations.sh/wifi_pass.sh)
  ```

- ## Pusher
    This will create an script-app called 'psh' and move it to '/usr/local/bin' that will add all files, commit with the message you passed as an argument and push to the main branch.
  ### Install
  ```bash
  echo 'git add . && git commit -m "$1" && git push origin main' | sudo tee -a /usr/local/bin/psh && sudo chmod +x /usr/local/bin/psh && clear
  ```
  ### Usage
  ```bash
  psh "commit message"
  ```
  ### To Uninstall
  ```bash
  sudo rm /usr/local/bin/psh
  ```