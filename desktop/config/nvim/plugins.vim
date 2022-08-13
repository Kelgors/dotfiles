call plug#begin()

Plug 'vim-airline/vim-airline' " status bar
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } " file explorer
Plug 'tpope/vim-commentary' " comments with gcc & gc
Plug 'ryanoasis/vim-devicons' " file icons
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dyng/ctrlsf.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'zivyangll/git-blame.vim'

call plug#end()
