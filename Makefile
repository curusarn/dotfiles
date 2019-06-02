SHELL=/bin/bash
VSCODE_EXTENSIONS=.dotfiles/vscode_extensions.txt
VSCODE_EXTENSIONS_TMP=/tmp/vscode_extensions.txt

all:
	make setup
	make keyboard_layouts
	make code_extensions
	make vim_extensions

setup:
	.dotfiles/setup.sh

keyboard_layouts:
	# setup udev rule that reloads keyboard layout when input device is (dis)connected
	sudo echo -e "#!/usr/bin/env bash\n/home/${USER}/bin/layout-reload &" | sudo tee /usr/local/bin/xkb-keyboard-layout-reload.sh >/dev/null
	sudo cp -f ~/.dotfiles/udev-99-xkb-keyboard-layout-reload.rules /etc/udev/rules.d/99-xkb-keyboard-layout-reload.rules
	sudo udevadm control --reload
	# run script to set default layout (with sudo to test if it works)
	sudo /home/${USER}/bin/layout-reload

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