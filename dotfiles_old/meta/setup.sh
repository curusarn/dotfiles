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


cd ~

## git
# setup repo
if [[ -d dotfiles-tmp ]]; then
    echo "setting up repo"
    # --links = copy symlinks as symlinks (don't follow, just copy)
    rsync --recursive --links --verbose --exclude '.git' dotfiles-tmp/ $HOME/
    rm --recursive dotfiles-tmp
fi

# dotfiles repo config
# hide untracked files + ugly options because dotfiles is bare repo
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME\
                                config status.showUntrackedFiles no

### CONFIG INCLUDES
# git global config
addInclude '.gitconfig' 'gitconfig' \
           '\[include\][^\[\]]*path = .dotfiles/gitconfig' \
           '[include]\n    path = .dotfiles/gitconfig'


## REMOTE SYNCED DOTFILES
## every file includes it's remote version
# bashrc -> remote
addInclude '.bashrc' 'bashrc' 'source ~/.dotfiles/bashrc' \
           '# added by .dotfiles/init.sh\nsource ~/.dotfiles/bashrc'

# zshrc -> remote
addInclude '.zshrc' 'zshrc' 'source ~/.dotfiles/zshrc' \
           '# added by .dotfiles/init.sh\nsource ~/.dotfiles/zshrc'

# shellrc -> remote
addInclude '.shellrc' 'shellrc' 'source ~/.dotfiles/shellrc' \
           '# added by .dotfiles/init.sh\nsource ~/.dotfiles/shellrc'


# detect distro and setup distro_paths
cd ~/.distro_paths
distro=`~/bin/detect-distro.sh`
echo "Distro detected: $distro"
ln --force --symbolic "$distro" "DISTRO" 

# set system layout to us caps:super using systemd 
sudo localectl set-x11-keymap us caps:super