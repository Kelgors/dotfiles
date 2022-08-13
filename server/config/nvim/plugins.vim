call plug#begin()

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } " file explorer
Plug 'tpope/vim-commentary' " comments with gcc & gc
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()