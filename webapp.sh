#!/bin/bash

# 1. download the pkg
wget http://packages.linuxmint.com/pool/main/w/webapp-manager/webapp-manager_1.1.1_all.deb

# 2. install the pkg
sudo gdebi -n webapp-manager_1.1.1_all.deb

# 3. remove the downloaded pkg 
rm webapp-manager_1.1.1_all.deb