" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EXPERIMENTAL CONFIG

" don't add space when joining lines - this doesn't behave as expected
" set nojoinspaces

" use system clipboard with nvim
set clipboard=unnamed

" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC CONFIG

syntax on
set number
set autoindent
set ignorecase
set smartcase
set nojoinspaces

" open new splits on right and below to not disrupt the position of the
" already open splits
set splitright
set splitbelow

" highlight as I search
set incsearch

" no .swp files
set noswapfile

" tabs are 4 spaces wide, transform tabs into spaces
"set shiftwidth=4
"set softtabstop=4
"set tabstop=4
"set expandtab

" keep x lines around cursor
set scrolloff=15

" increase limit for max number of files to open in tabs with `vim -p`
set tabpagemax=1024

" shorter timeout after ESC O
" never wait again for openning a new line
set ttimeoutlen=100

" predefine whitespace chars for :set list
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

" wrap text at 80 chars with 'gq'
"set textwidth=80

" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEYMAPPINGS


" move up and down inside of wrapped lines
nnoremap j gj
nnoremap k gk

" use <space>ui to switch tabs
nnoremap <space>i gt
nnoremap <space>u gT

" use <space>hjkl to switch between splits
nnoremap <space>h <C-w>h
nnoremap <space>j <C-w>j
nnoremap <space>k <C-w>k
nnoremap <space>l <C-w>l

" use <space>HJKL to move splits
nnoremap <space>H <C-w>H
nnoremap <space>J <C-w>J
nnoremap <space>K <C-w>K
nnoremap <space>L <C-w>L

" """"""""""""""""""""""""""""""""""""
" experimental KEYMAPPINGS

" use <space>; as alternative for :
nnoremap <space>; :

" use <space>w as alternative for :w<return>
nnoremap <space>w :w<return>
nnoremap <space>q :wq<return>
nnoremap <space>a :wqa<return>

" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UNDOFILE
" persistent undo history

" Let's save undo info!
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile


" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" HIGHLIGHT 81st CHARACTER

" highlight long lines
augroup vimrc_autocmds
    autocmd BufEnter * highlight OverLength ctermbg=darkred ctermfg=white
    autocmd BufEnter * match OverLength /\%81v./
augroup END


" highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
" match OverLength /\%81v.*/

" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" let &colorcolumn=join(range(81,81),",")

" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" WHEN WINDOW IS RESIZED => RESIZE SPLITS TO BE EQUAL

autocmd VimResized * wincmd =

" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" My jsonnet settings
augroup jsonnet_settings " {
    autocmd!
    autocmd BufNewFile,BufRead *.jsonnet set expandtab
    autocmd BufNewFile,BufRead *.jsonnet set shiftwidth=2
    autocmd BufNewFile,BufRead *.jsonnet set tabstop=2
    autocmd BufNewFile,BufRead *.libsonnet set expandtab
    autocmd BufNewFile,BufRead *.libsonnet set shiftwidth=2
    autocmd BufNewFile,BufRead *.libsonnet set tabstop=2
augroup END " }

" My js settings
augroup js_settings " {
    autocmd!
    autocmd BufNewFile,BufRead *.js set expandtab
    autocmd BufNewFile,BufRead *.js set shiftwidth=4
    autocmd BufNewFile,BufRead *.js set tabstop=4
augroup END " }
