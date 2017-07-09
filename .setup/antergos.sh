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

echo "Installing packages"
install_package_group essential
install_package_group xserver
install_package_group i3

echo "Copying files"
cp -v $base_path/files/* ~/

