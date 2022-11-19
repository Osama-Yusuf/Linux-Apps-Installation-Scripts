#!/bin/bash

read -p "Enter a name for the file " file_name
sudo cp $1 /usr/local/bin/$file_name && sudo chmod +x /usr/local/bin/$file_name
echo "File $file_name has been installed in /usr/local/bin"

# now you can run the script by typing the name you gave it
