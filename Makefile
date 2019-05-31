SHELL=/bin/bash
VSCODE_EXTENSIONS=.dotfiles/vscode_extensions.txt
VSCODE_EXTENSIONS_TMP=/tmp/vscode_extensions.txt

setup:
	.dotfiles/setup.sh

code_extensions:
	cat ${VSCODE_EXTENSIONS} | while read ex; do code --install-extension $$ex; done
	code --list-extensions > ${VSCODE_EXTENSIONS_TMP} \
		&& cat ${VSCODE_EXTENSIONS} >> ${VSCODE_EXTENSIONS_TMP} \
		&& cat ${VSCODE_EXTENSIONS_TMP} | sort -u > ${VSCODE_EXTENSIONS}