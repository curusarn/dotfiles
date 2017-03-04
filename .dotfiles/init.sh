#!/bin/bash

err () {
    printf "%s [ERROR]: %s\n" "$0" "$1" >&2
    exit 1
}

# adds include $4 to config file $1 if $3 is not present
addInclude () {
    includeTo="$1"
    backupTo="$2"
    grepStr="$3"
    addStr="$4"

    [[ $# -lt 4 ]] && err "not enough arguments for addInclude() function."

    if [[ ! -d .dotfiles/bak ]]; then
        printf "directory <.dotfiles/bak> does not exist - creating\n"
        mkdir .dotfiles/bak
    fi

    if [[ ! -f "$includeTo" ]]; then
        printf "file <%s> does not exist - creating\n" "$includeTo"
        touch "$includeTo"
    fi

    # if not already included
    if ! echo `cat "$includeTo"` | grep -q "$grepStr"; then
        # backup with timestamp
        cp "$includeTo" ".dotfiles/bak/${backupTo}"_`date "+%F_%T"`
        config=`cat "$includeTo"`
        echo -e "${addStr}\n${config}" > "$includeTo"
    fi
}

# bash_profile
cd ~

## git
# setup repo
if [[ -d dotfiles-tmp ]]; then
    echo "setting up repo"
    rsync --recursive --verbose --exclude '.git' dotfiles-tmp/ $HOME/
    rm --recursive dotfiles-tmp
fi

# dotfiles repo config
# hide untracked files + ugly options because dotfiles is bare repo
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME\
                                config status.showUntrackedFiles no

## config includes
# git global config
addInclude '.gitconfig' 'gitconfig' \
           '\[include\][^\[\]]*path = .dotfiles/gitconfig' \
           '[include]\n    path = .dotfiles/gitconfig'

# bashrc
addInclude '.bashrc' 'bashrc' 'source ~/.dotfiles/bashrc' \
           '# added by .dotfiles/init.sh\nsource ~/.dotfiles/bashrc'

# bash_profile
addInclude '.bash_profile' 'bash_profile' 'source ~/.dotfiles/bash_profile' \
           '# added by .dotfiles/init.sh\nsource ~/.dotfiles/bash_profile'

## vim
# clone vundle because it could be broken
mkdir -p ~/.vim/bundle 2>/dev/null
cd ~/.vim/bundle
rm -rf Vundle.vim
git clone https://github.com/VundleVim/Vundle.vim.git

# install plugins
vim +PluginInstall +qall


