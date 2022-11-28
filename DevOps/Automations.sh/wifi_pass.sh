#!/bin/bash

# going into the dir where wifi networks are stored
cd /etc/NetworkManager/system-connections/

# Array of all the files in this directory
files=(*)

echo "Enter the wifi Num. to see its password: "

# Number of elements in the array
num_wifi=${#files[@]}

# Removed the .nmconnection from the file name
for (( i=0; i<$num_wifi; i++ ))
do
    files[$i]=${files[$i]%.*}
done

# Printed the wifi names and numbers to choose from
select file in "${files[@]}"; do
    if [ 1 -le "$REPLY" ] && [ "$REPLY" -le "$num_wifi" ]; then
        echo
        echo "$file Password is: "
        # Added the .nmconnection to the file name to avoid file not found error
        sudo cat $file.nmconnection | grep psk= | cut -d '=' -f 2
        echo
        break
    else
        echo "Invalid selection. Try another one."
    fi
done