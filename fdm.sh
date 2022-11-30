#!/bin/bash
# by default fdm supports debian based distros only 
cd /home/$USER/Downloads

wget https://dn3.freedownloadmanager.org/6/latest/freedownloadmanager.deb

sudo dpkg -i freedownloadmanager.deb

sudo apt install -f

rm -f freedownloadmanager.deb

cd
