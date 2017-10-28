#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root. Please run with sudo." 
   exit 1
fi

bashrc="$HOME/.bashrc"

if grep -q "export LC_ALL" "$bashrc"
   then
      echo Bashrc already has locale settings
   else
      echo export LC_ALL=C >> $bashrc
      echo Added locale to bashrc
      . ~/.bashrc
fi

sudoers="/etc/sudoers"

if grep -q "$USER ALL=(ALL) NOPASSWD: ALL" "$sudoers"
   then
      echo Sudoers file already contains $USER
   else
      echo export $USER ALL=(ALL) NOPASSWD: ALL >> $sudoers
      echo Added $USER to sudoers file
      . ~/.bashrc
fi


mkdir Dev 

mkdir ~/.ssh

authkeys="$HOME/.ssh/authorized_keys"
if [ -f "$authkeys" ]
then
   echo "$file already exists."
else
   touch "$file"
fi

chmod 400 ~/.ssh/authorized_keys

apt-get update 

apt-get upgrade

apt-get install vim -y

apt-get install zsh -y

curl -o .z.sh https://raw.githubusercontent.com/rupa/z/master/z.sh

timedatectl set-timezone America/Chicago

curl -O https://raw.githubusercontent.com/Connor-Knabe/install-scripts/master/.zshrc

curl -O https://raw.githubusercontent.com/Connor-Knabe/install-scripts/master/.vimrc

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash

. ~/.bashrc

nvm install --lts

chsh -s $(which zsh)

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

npm install pm2@latest -g
