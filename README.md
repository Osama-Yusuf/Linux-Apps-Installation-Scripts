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
```
sudo snap install sleek
```

### [SuperProductivity To-do List](https://github.com/johannesjo/super-productivity/releases)
```
sudo snap install superproductivity
```