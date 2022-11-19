#!/bin/bash

cd /home/$USER/Downloads

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install gdebi
sudo gdebi -n google-chrome-stable_current_amd64.deb
rm -f google-chrome-stable_current_amd64.deb
cd
