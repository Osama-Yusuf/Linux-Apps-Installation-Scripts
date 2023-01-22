#!/bin/bash

# To install Flatpak on Ubuntu 18.10 (Cosmic Cuttlefish) or later, simply run:
sudo apt install flatpak
# The Flatpak plugin for the Software app makes it possible to install apps without needing the command line. To install, run:
sudo apt install gnome-software-plugin-flatpak
# Flathub is the best place to get Flatpak apps. To enable it, run:
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# now restart 
echo "Restart your pc now"


# some useful apps

# -------------------------------- otp-client -------------------------------- #
# 1. download the .flatpak file 
https://dl.flathub.org/repo/appstream/com.github.paolostivanin.OTPClient.flatpakref
# 2. install it 
flatpak install flathub com.github.paolostivanin.OTPClient
# 3. run it
flatpak run com.github.paolostivanin.OTPClient
# 4. remove the .flatpak file
rm com.github.paolostivanin.OTPClient.flatpakref