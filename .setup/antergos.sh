#!/bin/bash

base_path=~/.setup

echo "Updating system"
sudo pacman -Syu

echo "Install packages"
~/dotfiles-tmp/bin/pacsync install

echo "Copying files"
cp -vr $base_path/files/.??* ~/

echo "Enable NetworkManager.service"
sudo systemctl enable NetworkManager.service

echo "Initialize dotfiles"
.dotfiles/init.sh

echo "Bg image"
~/.setup/bg_image.sh

