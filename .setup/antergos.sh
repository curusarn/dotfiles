#!/bin/bash

base_path=~/.setup

echo "Updating system"
sudo pacman -Syu

echo "Install packages"
# dependencies and data for pacsync
sudo pacman -S yaourt lsb-release
cp -r ~/dotfiles-tmp/.pacsync ~
# pacsync
~/dotfiles-tmp/bin/pacsync install

echo "Initialize dotfiles"
# moves dotfiles-tmp contents to ~
.dotfiles/init.sh

echo "Copying files"
cp -vr $base_path/files/.??* ~/

echo "Enable NetworkManager.service"
sudo systemctl enable NetworkManager.service

echo "Bg image"
# X server has to be running for this to work
#~/.setup/bg_image.sh

