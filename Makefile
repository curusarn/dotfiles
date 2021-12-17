SHELL=/bin/bash
VSCODE_EXTENSIONS=dotfiles/vscode_extensions.txt
VSCODE_EXTENSIONS_TMP=/tmp/vscode_extensions.txt
GNOME_EXTENSIONS_ROOT=~/.local/share/gnome-shell/extensions

PACMAN_OPTS="--needed --noconfirm"

bootstrap:
	yadm bootstrap 
	# runs .config/yadm/bootstrap

install_packages:
	# sudo pacman -S --needed base-devel
	sudo pacman -S --needed bash-completion zsh-completions
	sudo pacman -S --needed moreutils jq net-tools
	sudo pacman -S --needed neovim
	sudo pacman -S --needed xcape
	sudo pacman -S --needed tig fzf thefuck tree
	sudo pacman -S --needed neofetch
	sudo pacman -S --needed dconf

install_spotify:
	# import spotify keys
	gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
	gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 2EBF997C15BDA244B6EBF5D84773BD5E130D1D45
	yay -S spotify

install_vscode:
	yay -S visual-studio-code-bin

install_apps: install_spotify install_vscode
	# yay -S google-chrome-stable
	#yay -S telegram-destop

install_oh-my-zsh: submodules
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	# copying the original .zshrc back
	cp -f ~/.zshrc.pre-oh-my-zsh ~/.zshrc

install_hyper-snazzy-gnome-terminal: submodules
	# hyper-snazzy
	cd dotfiles/submodules/hyper-snazzy-gnome-terminal && chmod +x hyper-snazzy.sh && ./hyper-snazzy.sh

install_patch_gnome-terminal-desktop:
	# gnome-teminal should always open maximized
	cat /usr/share/applications/org.gnome.Terminal.desktop \
		| sed 's/^Exec=gnome-terminal$$/Exec=gnome-terminal --maximize/' \
		| sed 's/^Exec=gnome-terminal --window$$/Exec=gnome-terminal --window --maximize/' \
		> ~/.local/share/applications/org.gnome.Terminal.desktop
	# you should see something like:
	#	TryExec=gnome-terminal
	#	Exec=gnome-terminal --maximize
	#	Exec=gnome-terminal --window --maximize
	#	Exec=gnome-terminal --preferences
	cat ~/.local/share/applications/org.gnome.Terminal.desktop | grep Exec
	# to revert this patch use:
	# 	rm ~/.local/share/applications/org.gnome.Terminal.desktop
	# 	update-desktop-database ~/.local/share/applications
	update-desktop-database ~/.local/share/applications
	# you might need to restart gnome using Alt+F2 > r
	# NOTE: maybe wait for a little bit
	# NOTE2: do not lock yourself out ;)

set_gnome_favourite-apps:
	gsettings set org.gnome.shell favorite-apps \
	"['org.gnome.Terminal.desktop', 'google-chrome.desktop', 'visual-studio-code.desktop', 'org.gnome.Nautilus.desktop', 'spotify.desktop']"

# TODO: save_gnome_favourite-apps:
# 	gsettings get ... > some_file
# 	# TODO: change set_gnome_favourite-apps

set_gnome: set_gnome_wm set_gnome_terminal \
	set_gnome_extension_put-window \
	set_gnome_extension_vertical-overview

set_gnome_wm: 
	# turn off a single key overlay to free caps_lock for escape on tap
	gsettings set org.gnome.mutter overlay-key "" 
	# more bindings for overview
	gsettings set org.gnome.shell.keybindings toggle-overview "['<Super>s', '<Super>a','<Super>space']"
	gsettings set org.gnome.shell.keybindings toggle-application-view "[]"

	# free up <Super>space
	gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Alt>z', 'XF86Keyboard']"
	gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "['<Shift><Alt>z', '<Shift>XF86Keyboard']"

	# switch to last window effectively
	gsettings set org.gnome.shell.window-switcher current-workspace-only false

	gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab', '<Super>i']"
	gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Alt><Shift>Tab', '<Super>u']"

	gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Super>Tab']"
	gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "['<Super><Shift>Tab']"
	
	gsettings set org.gnome.desktop.wm.keybindings cycle-windows "[]"
	gsettings set org.gnome.desktop.wm.keybindings cycle-windows-backward "[]"

	gsettings set org.gnome.desktop.wm.keybindings close "['<Super>q', '<Alt>F4']"
	# ??? colision with in-app fullscreen (use Super+f ??? - current used for toggle maximize)
	gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['F11']"

	# MOVEMENT
	gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-left "['<Super><Shift>h', '<Super><Shift>left']"
	gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-right "['<Super><Shift>l', '<Super><Shift>right']"

	gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['<Super>k', '<Super>up']"
	gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['<Super>j', '<Super>down']"
	gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up "[]"
	gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down "[]"
	# gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up "['<Super><Shift>k', '<Super><Shift>up']"
	# gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down "['<Super><Shift>j', '<Super><Shift>down']"

	gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "[]"
	gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "[]"
	gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "[]"
	gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "[]"

	# these special states are confusing to use because the windows always look the same
	gsettings set org.gnome.desktop.wm.keybindings toggle-on-all-workspaces "[]"
	gsettings set org.gnome.desktop.wm.keybindings toggle-above "[]" 

	# RESIZE WINDOWS
	gsettings set org.gnome.mutter.keybindings toggle-tiled-left "['<Super>comma', '<Super><Shift>comma']"
	gsettings set org.gnome.mutter.keybindings toggle-tiled-right "['<Super>period', '<Super><Shift>period']"
	# ^^^ workflow: move window to another monitor with Super+Shift+h and then resize it with Super+comma (requires releasing Shift)
	# 			these alternative binds make releasing Shift optional

	gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "['<Super>m', '<Super><Shift>m', '<Super>f']"

	gsettings set org.gnome.desktop.wm.keybindings minimize "['<Super>slash', '<Super><Shift>slash']" 
	gsettings set org.gnome.desktop.wm.keybindings maximize "[]"
	gsettings set org.gnome.desktop.wm.keybindings unmaximize "[]"

	# dynamic workspaces
	gsettings set org.gnome.mutter dynamic-workspaces true 

	# lock screen
	gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver "['<Super>escape', '<Super>0']"

	# absolute workspace switching
	gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>1', '<Super>home']"
	gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super>2']"
	gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super>3']"
	gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>4']"
	gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Super>5']"
	gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 "['<Super>6']"
	gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7 "['<Super>7']"
	gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-8 "['<Super>8']"
	gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-9 "['<Super>9']"
	gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-last "['<Super>end']"

	# CLEANUP
	gsettings set org.gnome.desktop.wm.keybindings lower "[]" 
	gsettings set org.gnome.desktop.wm.keybindings raise "[]" 
	gsettings set org.gnome.shell.keybindings switch-to-application-1 "[]"
	gsettings set org.gnome.shell.keybindings switch-to-application-2 "[]"
	gsettings set org.gnome.shell.keybindings switch-to-application-3 "[]"
	gsettings set org.gnome.shell.keybindings switch-to-application-4 "[]"
	gsettings set org.gnome.shell.keybindings switch-to-application-5 "[]"
	gsettings set org.gnome.shell.keybindings switch-to-application-6 "[]"
	gsettings set org.gnome.shell.keybindings switch-to-application-7 "[]"
	gsettings set org.gnome.shell.keybindings switch-to-application-8 "[]"
	gsettings set org.gnome.shell.keybindings switch-to-application-9 "[]"
	gsettings set org.gnome.shell.keybindings toggle-message-tray "[]"
	gsettings set org.gnome.shell.keybindings focus-active-notification "[]"


schema_gnometerminalkeybindings := org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/
set_gnome_terminal:
	# disable annoying confirmation
	gsettings set org.gnome.Terminal.Legacy.Settings confirm-close false
	gsettings set ${schema_gnometerminalkeybindings} paste "['<Ctrl><Shift>v', '<Super>v']"
	gsettings set ${schema_gnometerminalkeybindings} next-tab "['<Alt>i>']"
	gsettings set ${schema_gnometerminalkeybindings} prev-tab "['<Alt>u>']"

schema_mf := ${GNOME_EXTENSIONS_ROOT}/movefocus@simonlet.cz/schemas
set_extension_movefocus:
	gsettings --schemadir ${schema_mf} set org.gnome.shell.extensions.movefocus move-focus-left "['<Shift>h']"
	gsettings --schemadir ${schema_mf} set org.gnome.shell.extensions.movefocus move-focus-right "['<Shift>l']"
	gsettings --schemadir ${schema_mf} set org.gnome.shell.extensions.movefocus insert-new-workspace-down "['<Super>n']"
	gsettings --schemadir ${schema_mf} set org.gnome.shell.extensions.movefocus move-to-new-workspace-down "['<Super><Shift>n']"

# schemadir_vo := ${GNOME_EXTENSIONS_ROOT}/putWindow@clemens.lab21.org/schemas
# set_gnome_extension_put-window: ${GNOME_EXTENSIONS_ROOT}/putWindow@clemens.lab21.org
	
install_resh:
	curl -fsSL https://raw.githubusercontent.com/curusarn/resh/master/scripts/rawinstall.sh | bash

vim_extensions:
	# clone vundle because it could be broken
	mkdir -p ~/.vim/bundle 2>/dev/null
	cd ~/.vim/bundle
	rm -rf Vundle.vim
	git clone https://github.com/VundleVim/Vundle.vim.git
	# install plugins
	vim +PluginInstall +qall

code_extensions:
	# install from dotfiles
	cat ${VSCODE_EXTENSIONS} | while read ex; do code --install-extension $$ex; done
	# update dotfiles
	code --list-extensions > ${VSCODE_EXTENSIONS_TMP}
	cat ${VSCODE_EXTENSIONS} >> ${VSCODE_EXTENSIONS_TMP}
	cat ${VSCODE_EXTENSIONS_TMP} | sort -u > ${VSCODE_EXTENSIONS}

submodules:
	yadm submodule sync --recursive 
	yadm submodule update --init --recursive

gnome_extensions: ${GNOME_EXTENSIONS_ROOT}/vertical-overview@RensAlthuis.github.com
	
${GNOME_EXTENSIONS_ROOT}/vertical-overview@RensAlthuis.github.com:
	git clone https://github.com/RensAlthuis/vertical-overview.git
	cd vertical-overview
	make

