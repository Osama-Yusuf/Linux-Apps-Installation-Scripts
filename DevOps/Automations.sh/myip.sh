#!/bin/bash

hostname -I | awk '{print $1}'
# ifconfig | grep broadcast | awk 'NR>2{print $2}'
# selects the third row then the second column of the output to print out 
#
# ifconfig | grep broadcast | awk '{print $2}'
# selectsthe second column of the output to print out
