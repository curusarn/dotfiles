# Dotfiles

These are my dotfiles, they are not very nice but they are mine.  
My dotfiles include variety of scripts and config files I have created and collected.  
Despite that I try to keep my dotfiles as simple as possible. 
My primary OS is Antergos (Arch) and I also use Debian-based distributions.  
I use i3 window manager.  

This readme should be much longer. I will gladly explain anything about about my dotfiles. Feel free to contact me or create an issue.


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

#### Clone the repo
```bash
git clone --separate-git-dir=$HOME/.dotfiles git@github.com:curusarn/dotfiles.git dotfiles-tmp
```
OR
```bash
git clone --separate-git-dir=$HOME/.dotfiles https://github.com/curusarn/dotfiles.git dotfiles-tmp
```

#### Setup repo

This is the script I run every time I pull major dotfiles changes from git.  
It creates includes in `.bashrc`, `.gitconfig`, installs vim plugins, detects installed distro and more. 

```bash
dotfiles-tmp/.dotfiles/init.sh
```

### Create your own bare repo

This is how you can create your own bare repo.  
Or you can fork mine and customize it.

#### Create
```bash
git init --bare $HOME/.dotfiles
dotfiles remote add origin git@github.com:YOUR_LOGIN/dotfiles.git
```

#### Configure 
```bash
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config status.showUntrackedFiles no
```

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






