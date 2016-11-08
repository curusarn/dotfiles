#!/bin/bash

cd ~

## git
# setup repo
if [[ -d dotfiles-tmp ]]; then
    echo "setup repo"
    rsync --recursive --verbose --exclude '.git' dotfiles-tmp/ $HOME/
    rm --recursive dotfiles-tmp
fi

# dotfiles repo config
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME\
                                config status.showUntrackedFiles no
## config includes
# git global config
if [[ ! -f .gitconfig ]]; then
    touch .gitconfig
fi
if ! echo `cat .gitconfig` | grep -q '\[include\][^\[\]]*path = .dotfiles/gitconfig'; then # if not already in gitconfig
    cp -f .gitconfig .dotfiles/global_gitconfig.old
    gitconfig=`cat .gitconfig`
    echo -e "[include]\n    path = .dotfiles/gitconfig\n${gitconfig}" > .gitconfig
fi

# bashrc
if [[ ! -f .bashrc ]]; then
    touch .bashrc
fi
if ! echo `cat .bashrc` | grep -q 'source .dotfiles/bashrc'; then # if not already in bashrc
    cp -f .bashrc .dotfiles/bashrc.old
    bashrc=`cat .bashrc`
    echo -e "source .dotfiles/bashrc" > .bashrc
fi

## vim
# clone vundle
mkdir -p ~/.vim/bundle 2>/dev/null
cd ~/.vim/bundle
rm -rf Vundle.vim
git clone https://github.com/VundleVim/Vundle.vim.git

# install plugins
vim +PluginInstall +qall


