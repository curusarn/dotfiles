#!/bin/bash

# clone vundle
cd ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git

# install plugins
vim +PluginInstall +qall


