# Linux Apps Installation Scripts

## Tools

- [**AnyDesk**](#anydesk)
- [**Custom App Installer**](#custom-app-installer)
- [**CloudFlare**](#cloudflare)
- [**Free Download Manager**](#free-download-manager)
- [**Visual Studio Code**](#visual-studio-code)
- [**VLC media player**](#vlc-media-player)
- [**Pomodoro Timer**](#pomodoro-timer)
- [**Sleek To-do List**](#sleek-to-do-list)
- [**SuperProductivity To-do List**](#superproductivity-to-do-list)
- [**OneDrive**](#onedrive-1st-link-2nd-link)
- [**Locate**](#locate)

## You can execute the script directly without downloading it:

```
bash <(curl -s https://raw.githubusercontent.com/Osama-Yusuf/Linux-Apps-Installation-Scripts/main/<app_name>.sh)
```

## Or you can download it on your device, give it execution permissions & execute it:

```
curl "https://raw.githubusercontent.com/Osama-Yusuf/Linux-Apps-Installation-Scripts/main/<app_name>.sh" -o <app_name>.sh && chmod +x <app_name>.sh && ./<app_name>.sh
```

## The following links will execute scripts without downloading them:


### AnyDesk

```
source <(curl -s https://raw.githubusercontent.com/Osama-Yusuf/Linux-Apps-Installation-Scripts/main/anydesk.sh)
```

### CloudFlare

```
source <(curl -s https://raw.githubusercontent.com/Osama-Yusuf/Linux-Apps-Installation-Scripts/main/cloudflare.sh)
```

### Free Download Manager

```
source <(curl -s https://raw.githubusercontent.com/Osama-Yusuf/Linux-Apps-Installation-Scripts/main/fdm.sh)
```

### Visual Studio Code

```
source <(curl -s https://raw.githubusercontent.com/Osama-Yusuf/Linux-Apps-Installation-Scripts/main/vscode.sh)
```

### VLC media player

```
sudo snap install vlc
```

### [Pomodoro Timer](https://gnomepomodoro.org/)
for ubuntu
```
sudo apt-get install gnome-shell-pomodoro
```
for fedora
```
sudo dnf install gnome-pomodoro
```

### [Sleek To-do List](https://github.com/ransome1/sleek)
a simple user friendly Todo-list with priorities, project & tags as filters and due & thresholds as dates  
```
sudo snap install sleek
```

### [SuperProductivity To-do List](https://github.com/johannesjo/super-productivity)
This is a Todo-list with a time tracker to each task with also priorities, project & tags as filters and due & thresholds as dates and much more features 
```
sudo snap install superproductivity
```

### OneDrive [1st-link](https://github.com/abraunegg/onedrive/blob/master/docs/ubuntu-package-install.md#distribution-ubuntu-2004) [2nd-link](https://itslinuxfoss.com/install-use-onedrive-ubuntu-22-04/)
This document covers the appropriate steps to install the 'onedrive' client using the provided packages for Debian and Ubuntu.

### Locate
The locate command is a Unix utility used for quickly finding files and directories. The command is a more convenient and efficient alternative to the find command, which is more aggressive and takes longer to complete the search
```
sudo apt install mlocate
```
### Usage
```
locate <file_name>
```