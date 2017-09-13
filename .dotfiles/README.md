# dotfiles

## TODO
- add "lazy-loading" message about number of available updates to `.bashrc` 
- how to handle `bash` history, not syncing looses data, syncing slows down workflow, maybe `zsh` sloves this.
- `vim` `!grep -rni CURRENT_WORD` shortcut
- `vim` create function for `:set scrollbind` for all splits in current tab
- `vs ?` should be launchable on top of another open vim session
- `vs ?` should sort sessions by the time they were used last time
- make `vim` file autocomplete better (bash-like)
- make `vim` highlights changed lines (against git)
- vim Ctrl+w split switching is way too hard to press #isThisEmacs
- auto check & install dependencies (`i3blocks` stuff, ...)
- headless OPTION in `~/.dotfiles/headless` (1 = yes, 0 = no) -> don't install gui stuff on headless machines
- start using `zsh`, include configs 
- track vim sessions using `/tmp` rather than using shell variable - can't be set from within `vim`
- update `README` to describe all parts of dotfiles (dotfiles, pacsync, distro_paths) 

## Software
Incomplete list of software I like and use.  

### vim
one and only true editor.  

### i3wm
best tiling manager AFAIK.  

### feh
simple image viewer and backgroud setter  
  
set background: `feh --bg-scale image.img`  
set last used background: `~/.fehbg`  

### termite
my terminal emulator of choice  
  
intended for tiling managers, lightweight, mouse support, run-time font size changing, one simple config file, no DE specific dependencies.

## Setup
```bash
git init --bare $HOME/.dotfiles
dotfiles remote add origin git@github.com:curusarn/dotfiles.git
```

## Configuration
```bash
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config status.showUntrackedFiles no
```
*this is done by* `init.sh`  

## Usage
```bash
dotfiles status
dotfiles add .gitconfig
dotfiles commit -m 'Add gitconfig'
dotfiles push
```

## Replication
### Clone the repo
```bash
git clone --separate-git-dir=$HOME/.dotfiles git@github.com:curusarn/dotfiles.git dotfiles-tmp
```
OR
```bash
git clone --separate-git-dir=$HOME/.dotfiles https://github.com/curusarn/dotfiles.git dotfiles-tmp
```

### Setup stuffs
```bash
dotfiles-tmp/.dotfiles/init.sh
```

