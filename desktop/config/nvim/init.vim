" ~/.config/nvim/init.vim
source ~/.config/nvim/basic-settings.vim

" load plugins
source ~/.config/nvim/plugins.vim

command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

nnoremap <C-T> :NERDTreeToggle<CR>
nnoremap <F2> :NERDTreeFind<CR>
nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>
nmap 		 <C-P> :FZF<CR>

let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"
let g:airline_powerline_fonts = 1

highlight CocErrorFloat ctermfg=0
source ~/.config/nvim/coc.vim
source ~/.config/nvim/trim_trailing_whitespace.vim

" PlugClean to remove no longer used plugins
" PlugInstall
" PlugUpdate
"
" https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions
" :CocInstall coc-clangd
" :CocInstall coc-rls
" :CocInstall coc-rome
" :CocInstall coc-css
" :CocInstall coc-html
" :CocInstall coc-svg
" :CocInstall coc-yaml
" :CocInstall coc-graphql
" :CocInstall coc-sql
" :CocInstall coc-git
" :CocInstall coc-eslint
" :CocInstall coc-prettier
