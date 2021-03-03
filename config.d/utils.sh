#!/bin/bash


read -p "Reboot afeter installation? (Y/n) " ANWSER


# Patch sudo to version 1.9.5p2 to avoid CVE-2021-3156 
# buffer overflow exploit!
sudo pacman -Syu
sudo pacman -S wget --noconfirm
cd /tmp
wget "https://www.sudo.ws/dist/sudo-1.9.5p2.tar.gz"
tar xvzf sudo-1.9.5p2.tar.gz 
cd sudo-1.9.5p2/  
./configure
make && sudo make install 

# Installing NodeJS:
sudo pacman - S nodejs npm --noconfirm

# Installing pip & pipenv:
sudo pacman -S python-pip --noconfirm
pip install pipenv

# Installing Elixir & Erlang Virtual Machine:
sudo pacman -S elixir --noconfirm

# Installing Virtualbox:
sudo pacman -S virtualbox --noconfirm

# Installing Docker:
sudo tee /etc/modules-load.d/loop.conf <<< "loop"
sudo modprobe loop # if modprobe fails, reboot your system
sudo pacman -S docker --noconfirm
sudo systemctl start docker.service
sudo systemctl enable docker.service

# Installing VSCode:
cd ~/AUR
git clone https://AUR.archlinux.org/visual-studio-code-bin.git
cd visual-studio-code-bin/
makepkg -s
sudo pacman -U visual-studio-code-bin-* --noconfirm

# Installing AWS-CLI (Version 2):
cd /tmp
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Installing Terraform:
sudo pacman -S terraform --noconfirm

# Installing Ansible:
sudo pacman -S ansible --noconfirm

# Installing Steam & Proton:
sudo pacman -S steam --noconfirm

# Installing discord:
sudo pacman -S discord --noconfirm


if [[ $ANWSER == "Y" ]]; then
    echo "Rebooting..."
    reboot
else
    echo "Installation completed!"
    exit 0
fi