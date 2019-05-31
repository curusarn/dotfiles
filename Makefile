SHELL=/bin/bash
VSCODE_EXTENSIONS=.dotfiles/vscode_extensions.txt
VSCODE_EXTENSIONS_TMP=/tmp/vscode_extensions.txt

all:
	make setup
	make code_extensions
	make vim_extensions

setup:
	.dotfiles/setup.sh

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
	cat ${VSCODE_EXTENSIONS_TMP} | uniq > ${VSCODE_EXTENSIONS}