# Dotfiles

These are my dotfiles.

And this is an incomplete list of what I use:

OS: Manjaro  
DE: Gnome  
Terminal: gnome-terminal (with desktop file patched to always open fullscreen)  
Terminal theme: hyper-snazzy  
Shell: zsh with oh-my-zsh  
Prompt: pure  
Browser: Chome  
Password manager: 1password  
Dotfiles manager: yadm  
Shell history: resh  
Editor: vscode with neovim  
Vscode theme: One Dark Pro  
Gnome extensions: Overlay icons, Switcher, Put windows, Sound IO Chooser, Clipboard Indicator  
Gnome configuration and keyboard shortcuts: heavily customized  
Keyboard customizations: Capslock=Meta, Short press Caps -> Escape, Caps+space -> Gnome overlay  


## My workflow

I used i3wm before so I don't like to be forced to use mouse.  
But I also don't like to be forced to use the keyboard (+many other reasons) so I switched to Gnome.  
I customized Gnome to get a more keyboard-friendly workflow.  

### Keybindings

I use vim (in vscode) so my keybindings use hjkl. 

- Capslock works as Meta/Super key
- Single press of Caps works as Escape instead of openning Gnome Overview
- Meta+hjkl moves focus
    - Meta+jk "moves focus" down/up between workspaces
    - Meta+hl moves focus left/right between windows (and displays)
        - only possible using this extension https://github.com/negesti/gnome-shell-extensions-negesti
- Meta+Shift+hjkl moves windows (and focus)

Some more keybindings to resize windows: maximize, tile left, tile right, minimize  
Rebind Alt+Tab to Meta+ui so it's closer.  
Meta+Enter to launch a new fullscreen terminal.  
Meta+q to close a window.

### Search open windows

This extension fuzzy searches windows by title: https://github.com/daniellandau/switcher


## Setup step-by-step

*This was written to be followed by me (use at your own risk)*

### Setup

1. Install Manjaro Gnome with disk encryption
1. Refresh mirrorlist `sudo pacman-mirrors -g`
1. Update
1. Reboot

### Manjaro hello

1. Check default apps
    - Install all fonts
    - Uninstall contact app
1. Set Layout to Gnome (via Manjaro Hello)
1. Do not launch manjaro hello on start

### Manjaro settings

1. Install GPU drivers (maybe fixes issues from the next section)

### Display settings

1. ??? Install xorg-xdpyinfo
1. Delete `~/.config/monitors.xml` (it sometimes gets corrupted)
1. Setup displays

### Gnome settings

1. Naturall scrolling

### Yay

1. Install all base-devel: `sudo pacman -S base-devel yay` 

### Chrome

1. Install Chrome
    - `yay -S google-chrome`
1. Log into 1Password website
1. Log into Chrome
1. Log into 1Password
1. Log into other extensions
1. Download wallpaper and avatar from drive
1. Get SSH keys
1. Use system title bar (more consistent window focus indication)
    - Settings > Appearance > Show system title bar and borders

### SSH

1. Set file permissions for SSH keys to 600

### Gnome tweaks

1. Do nothing when the lid is closed
    - General
1. Dark theme (Matcha-dark-sea / whatever is default +dark)
    - Appearance
1. Set wallpaper
    - Appearance
1. Make Capslock additional Super
    - Keyboard & Mouse > Additional Layout Options

### Dotfiles

1. Install git
    - `sudo pacman -S git`
1. Install yadm
    - `yay -S yadm`
1. yadm clone, yadm bootstrap
1. make install_packages
1. make install_oh-my-zsh
1. make install_resh
1. make install_* 

### Gnome tweaks

1. Run xcape on start up
    - Startup applications > Xcape caps_escape

### Gnome terminal

1. create a dummy profile for gnome-terminal (otherwise hyper-snazzy breaks https://github.com/tobark/hyper-snazzy-gnome-terminal/issues/3)
1. `make install_hyper-snazzy`
1. Set hyper-snazzy as default theme
1. Patch Gnome-terminal to always launch fullscreen
    - `make install_patch_gnome-terminal-desktop`

### Gnome settings 

1. Create shortcut to launch terminal using Super+Enter
    - Keyboard shortcuts > scrolldown > + > `gnome-terminal --window --maximize`
1. ? Create shortcut to launch small terminal using Super+' 
    - ... > `gnome-terminal --window`
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
1. Log into apps

### Gnome extensions

1. Install and build
    - `make gnome_extensions`
1. Enable Extensions
    - Overlay icons, Switcher, Put windows, Sound IO Chooser, Clipboard Indicator
1. Import settings
    - `make set_gnome_ ...`
    - `make set_gnome_extension_ ...`

