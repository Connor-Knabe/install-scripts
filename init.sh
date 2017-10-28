#!/bin/bash



if [[ ! $EUID -ne 0 ]]; then
   echo "This script should not be run as root. Please run without sudo." 
   exit 1
fi



echo Hi $USER
sleep 1
echo About to start installing scripts
sleep 1

echo -n "Have you changed your default password? (y/n)"
read answer
if echo "$answer" | grep -iq "^y" ;then
    echo "It's great to hear that!
    sleep 2
else
    echo "Might be a good idea to do that :)"
    passwd
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

if sudo grep -q "$USER ALL=(ALL) NOPASSWD: ALL" "$sudoers"
   then
      echo Sudoers file already contains $USER
   else
      echo "$USER ALL=(ALL) NOPASSWD: ALL" >> $sudoers
      echo Added $USER to sudoers file
      . ~/.bashrc
fi

#set timezone
timedatectl set-timezone America/Chicago

mkdir Dev 
mkdir ~/.ssh

authkeys="$HOME/.ssh/authorized_keys"
if [ -f "$authkeys" ]
then
   echo "$file already exists."
else
   touch "$file"
fi
sudo chmod 400 ~/.ssh/authorized_keys
sudo apt-get update 
sudo apt-get upgrade
sudo apt-get install vim -y
sudo apt-get install zsh -y
#install node for root user
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install nodejs -y

curl -s  -o z.sh https://raw.githubusercontent.com/rupa/z/master/z.sh
curl -s  -O https://raw.githubusercontent.com/Connor-Knabe/install-scripts/master/.vimrc
curl -s -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash

. ~/.bashrc
. ~/.zshrc

nvm install 8
sudo chsh -s $(which zsh)
sh -s -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
curl -s -O https://raw.githubusercontent.com/Connor-Knabe/install-scripts/master/.zshrc

npm install pm2@latest -g
