#!/bin/bash

## git
# setup repo
rsync --recursive --verbose --exclude '.git' dotfiles-tmp/ $HOME/
rm --recursive dotfiles-tmp

# configure git
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME\
                                config status.showUntrackedFiles no


## vim
# clone vundle
cd ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git

# install plugins
vim +PluginInstall +qall


