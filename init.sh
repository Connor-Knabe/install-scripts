#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script should be run as root. Please run with sudo." 
   exit 1
fi

if [ "$#" -ne 1 ]; then
  echo "Need to pass in \$USER as argument!"
  exit 1
fi

USR=$1
echo Hi $USR
sleep 1
echo About to start installing scripts
sleep 1

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

if grep -q "$USR ALL=(ALL) NOPASSWD: ALL" "$sudoers"
   then
      echo Sudoers file already contains $USR
   else
      echo "$USR ALL=(ALL) NOPASSWD: ALL" >> $sudoers
      echo Added $USR to sudoers file
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

sudo -H -u $USR curl -s  -o .z.sh https://raw.githubusercontent.com/rupa/z/master/z.sh

timedatectl set-timezone America/Chicago

sudo -H -u $USR curl -s -O https://raw.githubusercontent.com/Connor-Knabe/install-scripts/master/.zshrc

sudo -H -u $USR curl -s  -O https://raw.githubusercontent.com/Connor-Knabe/install-scripts/master/.vimrc

sudo -H -u $USR curl -s -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash

. ~/.bashrc

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

sudo -H -u $USR nvm install --lts

chsh -s $(which zsh)

sudo -H -u $USR sh -s -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

sudo -H -u $USR npm install pm2@latest -g
