# Dotfiles

These are my dotfiles, they are not very nice but they are mine.  
My dotfiles include variety of scripts and config files I have created and collected.  
Despite that I try to keep my dotfiles as simple as possible.  
My primary OS is Antergos (Arch) and I also use Debian-based distributions.  
I use i3 window manager.  

This readme should be much longer.  
I will gladly explain anything about about my dotfiles.  
Feel free to contact me or create an issue.


## Bare repository

I use bare git repository in my home directory for dotfiles synchronization.  
This means I don't have to symlink all synchronized config files because they are in my home directory.

### Usage

```bash
dotfiles status
dotfiles add .gitconfig
dotfiles commit -m 'Add gitconfig'
dotfiles push
```

### Replication

This is how I setup my dotfiles on new machine.

#### 1. Clone the repo
```bash
git clone --separate-git-dir=$HOME/.dotfiles git@github.com:curusarn/dotfiles.git dotfiles-tmp
```
OR
```bash
git clone --separate-git-dir=$HOME/.dotfiles https://github.com/curusarn/dotfiles.git dotfiles-tmp
```

#### 2. Setup repo

This is the script I run every time I pull major dotfiles changes from git.  
This script creates includes in `.bashrc`, `.gitconfig`, installs vim plugins, detects installed distro and more. 

```bash
dotfiles-tmp/.dotfiles/setup.sh
```

### Create your own bare repo

This is how you can create your own bare repo.  
Or you can fork mine and customize it.

#### 1. Create
```bash
git init --bare $HOME/.dotfiles
dotfiles remote add origin git@github.com:YOUR_LOGIN/dotfiles.git
```

#### 2. Configure 
```bash
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config status.showUntrackedFiles no
```

## Shell startup files
Features:
- Support local changes
- Include `./bashrc` in login shells
- Effortless synchronization
- Work out-of-the-box
- Support `bash` and `zsh`

Running `.dotfiles/init.sh` sets up and fixes all the includes and creates files if necessary.
No configuration needed.

## Software
Incomplete list of software I like and use.  

### vim
one and only true editor.  

I use Vundle for vim plugin management.

### i3wm
best tiling manager AFAIK.  

### feh
simple image viewer and backgroud setter  
  
set background: `feh --bg-scale image.img`  
set last used background: `~/.fehbg`  

### termite
my terminal emulator of choice  
  
intended for tiling managers, lightweight, mouse support, run-time font size changing, one simple config file, no DE specific dependencies.

### ranger
cli file browser with vi-like keybindings

To stay in last directory after exiting ranger: `alias='source ranger'`

### pcmanfm
lightweigth gui file browser

### ncdu
ncurses tool that helps you figure out why is your disk space gone


## Setup step-by-step

### Setup

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

1. Install all base-devel: `pacman -S base-devel` 
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
1. Log into all 100 extensions
1. Download wallpaper and avatar
1. Get SSH keys

### SSH

1. Set file permissions for SSH keys to 600

### 

### Gnome tweaks

1. Do nothing when the lid is closed
    - General
1. Dark theme (Matcha-dark-sea / whatever-is-default-dark)
    - Appearance
1. Set wallpaper
    - Appearance
1. Make Capslock additional Super
    - Keyboard & Mouse > Additional Layout Options
1. ??? 8 Static workspaces
    - Workspaces

### Dotfiles

1. Install git and yadm
1. 
