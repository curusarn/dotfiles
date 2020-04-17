# Dotfiles

TODO: write somthing here


## Setup step-by-step

### Setup

1. Install Manjaro Gnome
1. Update
1. Reboot

### Manjaro hello

1. Check default apps
    - Install all fonts
    - Uninstall contact app
1. Set Layout to Gnome (via Manjaro Hello)
1. Do not launch manjaro hello on start

### Nvidia - this is why we can't have nice things

1. Check display settings 
1. install xorg-xdpyinfo
1. mess around with displays
1. give up 

### Gnome settings

1. Naturall scrolling

### Yay

1. Install all base-devel: `sudo pacman -S base-devel` 
1. Install yay
    - `git clone https://aur.archlinux.org/yay.git`
    - `cd yay`
    - `makepkg -si`

### Chrome

1. Install Chrome
    - `yay -S google-chrome`
1. Log into 1Password website
1. Log into Chrome
1. Log into 1Password
1. Log into other extensions
1. Download wallpaper and avatar from drive
1. Get SSH keys

### SSH

1. Set file permissions for SSH keys to 600

### Gnome tweaks

1. Do nothing when the lid is closed
    - General
1. Dark theme (Matcha-dark-sea / whatever-is-default-dark)
    - Appearance
1. Set wallpaper
    - Appearance
1. Make Capslock additional Super
    - Keyboard & Mouse > Additional Layout Options
1. 8 Static workspaces
    - Workspaces

### Dotfiles

1. Install git and yadm
1. yadm clone, yadm bootstrap
1. make install_packages
1. make install_oh-my-zsh
1. make install_resh
1. make install_* 

### Gnome terminal

1. create a dummy profile for gnome-terminal (otherwise hyper-snazzy breaks https://github.com/tobark/hyper-snazzy-gnome-terminal/issues/3)
1. `make install_hyper-snazzy`
1. Set hyper-snazzy as default theme
1. Patch Gnome-terminal to always launch fullscreen
    - `make install_patch_gnome-terminal-desktop`

### Gnome settings 

1. Create shortcut to launch terminal using Super+Enter
    - Keyboard shortcuts > scrolldown > + > `gnome-teminal --window --maximize`
1. ? Create shortcut to launch small terminal using Super+' 
    - ... > `gnome-teminal --window`
1. Set Search to: Terminal, Files and Calculator (in that order)
1. Set screen lock to 30 minutes
    - Privacy > Screen Lock
1. Set automatic suspend to ???
1. Never prompt to start programs
    - Removable media
1. Set avatar
    - User

### Applications

1. Install applications
    - `make install_apps`
1. Set Favourite apps
    - `make set_gnome_favourite-apps`
1. 

### Gnome extensions

1. Install and build
    - `make gnome_extensions`
1. Enable Extensions
1. Import settings
    - `make set_gnome_extension_ ...`

