#!/bin/bash

if grep -q "helloworld" ~/.bashrc; then
    echo "aliases already exist"
else
    tee -a ~/.bashrc > /dev/null <<EOT
alias tag='helloworld'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias c='clear'
alias py='python3'
alias kl='kubectl'
alias myip="echo $(hostname -I | awk '{print $1}')"
EOT
    echo "Aliases copied to ~/.bashrc ('ls -alf=ll' | 'clear=c' | 'python3=py' | 'kubectl=kl' | 'myip')"
    source $HOME/.bashrc
fi

# scp -i <key.pem> alias.sh <username>@<machine_ip>:<path_to_be_copied_in>