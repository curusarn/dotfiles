#!/bin/bash

base_path=~/.setup

function install_package_group {
    path="$1"
    pkgs=`cat $base_path/packages/$path | tr '\n' ' '`
    echo "Installing group <$path>"
    echo "$pkgs"
    sudo pacman -S $pkgs
}


echo "Updating system"
sudo pacman -Syu

sudo pacsave load core chrome 

echo "Copying files"
cp -vr $base_path/files/.??* ~/

echo "Enable NetworkManager.service"
sudo systemctl enable NetworkManager.service
