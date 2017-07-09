#!/bin/bash

function install_package_group {
    pkg_path=~/.setup/packages
    path="$1"
    pkgs=`cat $pkg_path/$path | tr '\n' ' '`
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

