SHELL=/bin/bash
VSCODE_EXTENSIONS=dotfiles/vscode_extensions.txt
VSCODE_EXTENSIONS_TMP=/tmp/vscode_extensions.txt

all:
	make bootstrap
	make code_extensions
	make vim_extensions

bootstrap:
	yadm bootstrap 
	# .config/yadm/bootstrap

install_packages:
	sudo pacman -S --needed bash-completion zsh-completions
	sudo pacman -S --needed tig
	sudo pacman -S --needed neovim
	sudo pacman -S --needed neofetch
	sudo pacman -S --needed xcape

install_apps:
	sudo pacman -S --needed telegram-destop
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
	# NOTE: maybe wait for a little bit
	# NOTE2: do not lock yourself out ;)

set_gnome_favourite-apps:
	gsettings set org.gnome.shell favorite-apps \
	"['org.gnome.Terminal.desktop', 'google-chrome.desktop', 'visual-studio-code.desktop', 'org.gnome.Nautilus.desktop', 'spotify.desktop', 'telegramdesktop.desktop']"

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

gnome_extensions: submodules
	cd ~/.local/share/gnome-shell/extensions/windowoverlay-icons@sustmidown.centrum.cz \
		&& make all

submodules:
	yadm submodule sync --recursive 
	yadm submodule update --init --recursive