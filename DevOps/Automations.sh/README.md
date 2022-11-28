# Bash scripts to automate iterative tasks  

## Scripts

- [**Docker Images and Containers Cleaner**](#docker-images-and-containers-cleaner)
- [**Kubernetes CLI auto-completion**](#kubernetes-cli-auto-completion)
- [**Fav Bash Aliases**](#fav-bash-aliases)
- [**MyIP**](#myip)
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

## Docker Images and Containers Cleaner
Removes all none images & none containers and can be extended to do more with args.

### Install
```
source <(curl -s https://raw.githubusercontent.com/Osama-Yusuf/Linux-Apps-Installation-Scripts/main/DevOps/Automations.sh/clean_docker.sh)
```

### Usage
```
Usage: ./clean_none.sh [OPTION]
  -l, --last      remove last image created
  -i, --image     remove specific image by id
  -e, --exited    remove all exited containers
  -c, --container remove specific container by id
  -h, --help      display this help and exit
```

## Kubernetes CLI auto-completion

```
source <(curl -s https://raw.githubusercontent.com/Osama-Yusuf/Linux-Apps-Installation-Scripts/main/DevOps/Automations.sh/k8s_autocompelete.sh)
```

## Fav Bash Aliases
Adds more aliases (ls -alf=ll, clear=c, python3=py, kubectl=kl, myip) to the ~/.bashrc file

```
source <(curl -s https://raw.githubusercontent.com/Osama-Yusuf/Linux-Apps-Installation-Scripts/main/DevOps/Automations.sh/alias.sh)
```

## MyIP

```
source <(curl -s https://raw.githubusercontent.com/Osama-Yusuf/Linux-Apps-Installation-Scripts/main/DevOps/Automations.sh/myip.sh)
```

## WIfi Passwords

```
    source <(curl -s https://raw.githubusercontent.com/Osama-Yusuf/Linux-Apps-Installation-Scripts/main/DevOps/Automations.sh/wifi_pass.sh)
```


