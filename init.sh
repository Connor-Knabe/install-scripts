#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root. Please run with sudo." 
   exit 1
fi

apt-get update 

apt-get upgrade

apt-get install vim

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

curl https://raw.githubusercontent.com/rupa/z/master/z.sh

mv z.sh .z.sh

timedatectl set-timezone America/Chicago

curl https://raw.githubusercontent.com/Connor-Knabe/install-scripts/master/.zshrc

curl https://raw.githubusercontent.com/Connor-Knabe/install-scripts/master/.vimrc

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash

nvm install --lts
