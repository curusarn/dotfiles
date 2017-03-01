# dotfiles

## TODO
- vim sessions saving (typing ~/.vim/sessions is dumb)
- include i3 configs (i3, i3blocks, rofi/dmenu-recency)
- setle with one termainal emulator and include color setting
- debian & antergos version (distro lookup in `init.sh`, debian as headless by default)
- headless OPTION in ~/.dotfiles/headless (1 = yes, 0 = no)

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
**This is done by** `init.sh` 

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

