#!/bin/bash

echo "Updating system"
sudo pacman -Syu

echo "Installing packages"
sudo pacman -S\
    git\
    vim\
    i3wm\
    rofi\
    feh\
    i3blocks


