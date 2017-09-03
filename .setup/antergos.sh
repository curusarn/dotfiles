#!/bin/bash

base_path=~/.setup

echo "Updating system"
sudo pacman -Syu

echo "Install packages"
bin/pacsave load core pcmanfm spotify utils video

echo "Copying files"
cp -vr $base_path/files/.??* ~/

echo "Bg image"
~/.setup/bg_image.sh

echo "Enable NetworkManager.service"
sudo systemctl enable NetworkManager.service

echo "Initialize dotfiles"
.dotfiles/init.sh
