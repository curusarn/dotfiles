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

install_apps:
	# yay -S google-chrome-stable
	yay -S visual-studio-code-bin
	yay -S telegram-destop
	yay -S spotify

install_oh-my-zsh: submodules
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	# copying the original .zshrc back
	cp ~/.zshrc.pre-oh-my-zsh ~/.zshrc

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
	"['org.gnome.Terminal.desktop', 'google-chrome.desktop', 'visual-studio-code.desktop', 'org.gnome.Nautilus.desktop', 'spotify.desktop', 'telegramdesktop.desktop']"

# TODO: save_gnome_favourite-apps:
# 	gsettings get ... > some_file
# 	# TODO: chnage set_gnome_favourite-apps

set_gnome: set_gnome_wm set_gnome_terminal \
	set_gnome_extension_switcher set_gnome_extension_window-overlay-icons set_gnome_extension_put-window

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
	gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up "['<Super><Shift>k', '<Super><Shift>up']"
	gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down "['<Super><Shift>j', '<Super><Shift>down']"

	gsettings set org.gnome.desktop.wm.keybindings toggle-on-all-workspaces "['<Super>semicolon']"
	# double bindings do not work :/
	# gsettings set org.gnome.desktop.wm.keybindings toggle-above "['<Super>semicolon']" 


	# RESIZE WINDOWS
	gsettings set org.gnome.mutter.keybindings toggle-tiled-left "['<Super>comma', '<Super><Shift>comma']"
	gsettings set org.gnome.mutter.keybindings toggle-tiled-right "['<Super>period', '<Super><Shift>period']"
	# ^^^ workflow: move window to another monitor with Super+Shift+h and then resize it with Super+comma (requires releasing Shift)
	# 			these alternative binds make releasing Shift optional

	gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "['<Super>m', '<Super><Shift>m', '<Super>f']"

	gsettings set org.gnome.desktop.wm.keybindings minimize "['<Super>slash', '<Super><Shift>slash']" 
	gsettings set org.gnome.desktop.wm.keybindings maximize "[]"
	gsettings set org.gnome.desktop.wm.keybindings unmaximize "[]"

	# CLEANUP
	gsettings set org.gnome.desktop.wm.keybindings lower "[]" 
	gsettings set org.gnome.desktop.wm.keybindings raise "[]" 

schemadir_sw := ${GNOME_EXTENSIONS_ROOT}/switcher@landau.fi/schemas
set_gnome_extension_switcher: ${GNOME_EXTENSIONS_ROOT}/switcher@landau.fi 
	gsettings --schemadir ${schemadir_sw} set org.gnome.shell.extensions.switcher show-switcher "['<Super>w', '<Super>o']"
	gsettings --schemadir ${schemadir_sw} set org.gnome.shell.extensions.switcher show-launcher "['<Super>e', '<Super>p']"

	gsettings --schemadir ${schemadir_sw} set org.gnome.shell.extensions.switcher icon-size "uint32 18"
	gsettings --schemadir ${schemadir_sw} set org.gnome.shell.extensions.switcher font-size "uint32 18"
	gsettings --schemadir ${schemadir_sw} set org.gnome.shell.extensions.switcher max-width-percentage "uint32 60"
	# use numbers to activate windows
	gsettings --schemadir ${schemadir_sw} set org.gnome.shell.extensions.switcher activate-by-key "uint32 2"
	# order by relevance
	gsettings --schemadir ${schemadir_sw} set org.gnome.shell.extensions.switcher ordering "uint32 1"
	gsettings --schemadir ${schemadir_sw} set org.gnome.shell.extensions.switcher never-show-onboarding true

schema_gnometerminalkeybindings := org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/
set_gnome_terminal:
	# disable annoying confirmation
	gsettings set org.gnome.Terminal.Legacy.Settings confirm-close false
	gsettings set ${schema_gnometerminalkeybindings} paste "['<Ctrl><Shift>v', '<Super>v']"
	gsettings set ${schema_gnometerminalkeybindings} next-tab "['<Alt>i>']"
	gsettings set ${schema_gnometerminalkeybindings} prev-tab "['<Alt>u>']"
	# free up
	gsettings set org.gnome.shell.keybindings toggle-message-tray "['<Super>n']"
	gsettings set org.gnome.shell.keybindings focus-active-notification "['<Super><Shift>n', '<Super>b']"

schemadir_woi := ${GNOME_EXTENSIONS_ROOT}/windowoverlay-icons@sustmidown.centrum.cz/schemas
set_gnome_extension_window-overlay-icons: ${GNOME_EXTENSIONS_ROOT}/windowoverlay-icons@sustmidown.centrum.cz
	gsettings --schemadir ${schemadir_woi} set org.gnome.shell.extensions.windowoverlay-icons icon-horizontal-alignment right
	gsettings --schemadir ${schemadir_woi} set org.gnome.shell.extensions.windowoverlay-icons icon-vertical-alignment bottom
	gsettings --schemadir ${schemadir_woi} set org.gnome.shell.extensions.windowoverlay-icons icon-size-relative false
	gsettings --schemadir ${schemadir_woi} set org.gnome.shell.extensions.windowoverlay-icons icon-opacity-focus 255
	gsettings --schemadir ${schemadir_woi} set org.gnome.shell.extensions.windowoverlay-icons icon-opacity-blur 255
	gsettings --schemadir ${schemadir_woi} set org.gnome.shell.extensions.windowoverlay-icons icon-size 75

schemadir_pw := ${GNOME_EXTENSIONS_ROOT}/putWindow@clemens.lab21.org/schemas
set_gnome_extension_put-window: ${GNOME_EXTENSIONS_ROOT}/putWindow@clemens.lab21.org
	gsettings --schemadir ${schemadir_pw} set org.gnome.shell.extensions.org-lab21-putwindow move-focus-animation 0
	gsettings --schemadir ${schemadir_pw} set org.gnome.shell.extensions.org-lab21-putwindow move-focus-west "['<Super>h', '<Super>left']"
	gsettings --schemadir ${schemadir_pw} set org.gnome.shell.extensions.org-lab21-putwindow move-focus-south "['']"
	gsettings --schemadir ${schemadir_pw} set org.gnome.shell.extensions.org-lab21-putwindow move-focus-north "['']"
	gsettings --schemadir ${schemadir_pw} set org.gnome.shell.extensions.org-lab21-putwindow move-focus-east "['<Super>l', '<Super>right]"
	
	
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

gnome_extensions: ${GNOME_EXTENSIONS_ROOT}/windowoverlay-icons@sustmidown.centrum.cz \
		${GNOME_EXTENSIONS_ROOT}/sound-output-device-chooser@kgshank.net \
		${GNOME_EXTENSIONS_ROOT}/clipboard-indicator@tudmotu.com \
		${GNOME_EXTENSIONS_ROOT}/switcher@landau.fi \
		${GNOME_EXTENSIONS_ROOT}/putWindow@clemens.lab21.org
	# ${GNOME_EXTENSIONS_ROOT}/paperwm@hedning\:matrix.org \

	
	cd ${GNOME_EXTENSIONS_ROOT}/windowoverlay-icons@sustmidown.centrum.cz \
		&& git pull \
		&& make all 
	# TODO: only do make all when there are changes

	cd ${GNOME_EXTENSIONS_ROOT}/gse-sound-output-device-chooser_git \
		&& git pull
		
	cd ${GNOME_EXTENSIONS_ROOT}/clipboard-indicator@tudmotu.com \
		&& git pull
	
	# cd ${GNOME_EXTENSIONS_ROOT}/paperwm@hedning:matrix.org \
		&& git pull

	cd ${GNOME_EXTENSIONS_ROOT}/switcher@landau.fi \
		&& git pull

	cd ${GNOME_EXTENSIONS_ROOT}/putWindow@clemens.lab21.org \
		&& git pull

${GNOME_EXTENSIONS_ROOT}/windowoverlay-icons@sustmidown.centrum.cz:
	git clone https://github.com/sustmi/gnome-shell-extension-windowoverlay-icons.git $@
	# requires build
	cd $@ && make all

${GNOME_EXTENSIONS_ROOT}/sound-output-device-chooser@kgshank.net:
	git clone https://github.com/kgshank/gse-sound-output-device-chooser.git ${GNOME_EXTENSIONS_ROOT}/gse-sound-output-device-chooser_git
	# symlink because of nested structure
	ln -s ${GNOME_EXTENSIONS_ROOT}/gse-sound-output-device-chooser_git/sound-output-device-chooser@kgshank.net \
		${GNOME_EXTENSIONS_ROOT}/sound-output-device-chooser@kgshank.net

${GNOME_EXTENSIONS_ROOT}/clipboard-indicator@tudmotu.com:
	git clone https://github.com/Tudmotu/gnome-shell-extension-clipboard-indicator.git $@

${GNOME_EXTENSIONS_ROOT}/switcher@landau.fi:
	git clone https://github.com/daniellandau/switcher.git $@

${GNOME_EXTENSIONS_ROOT}/putWindow@clemens.lab21.org:
	sudo pacman -S libwnck3
	git clone https://github.com/negesti/gnome-shell-extensions-negesti.git $@
	
# ${GNOME_EXTENSIONS_ROOT}/paperwm@hedning\:matrix.org:
# 	git clone https://github.com/paperwm/PaperWM.git $@
# 
# install_paperwm: ${GNOME_EXTENSIONS_ROOT}/paperwm@hedning\:matrix.org
# 	cd ${GNOME_EXTENSIONS_ROOT}/paperwm@hedning:matrix.org \
# 		&& ./install.sh
