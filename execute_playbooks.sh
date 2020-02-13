#!/usr/bin/env bash

title() {
    local color='\033[1;37m'
    local nc='\033[0m'
    printf "\n${color}$1${nc}\n"
}

title "Install zsh"
sudo ansible-galaxy install viasite-ansible.zsh --force
ansible-galaxy install viasite-ansible.zsh --force
ansible-playbook -i "localhost," -c local ./zsh.yml
sudo ansible-playbook -i "localhost," -c local ./zsh.yml --extra-vars="zsh_user=$(whoami)"

title "Install & configure basic utilities"
sudo ansible-playbook -i "localhost," -c local ./update.yml
ansible-playbook -i "localhost," -c local ./basics.yml
sudo ansible-playbook -i "localhost," -c local ./sudo_basics.yml

title "Install vscode"
ansible-galaxy install gantsign.visual-studio-code --force
ansible-playbook -i "localhost," -c local ./vscode.yml

os_string=`cat /etc/issue`

if [[ $os_string != *"Kali"* ]]; then
  title "Install metasploit"
  ansible-playbook -i "localhost," -c local ./metasploit.yml
fi

title "Install pwndbg"
ansible-playbook -i "localhost," -c local ./pwndbg.yml




