" ~/.config/nvim/init.vim
source ~/.config/nvim/basic-settings.vim

" load plugins
source ~/.config/nvim/plugins.vim

command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

nnoremap <C-T> :NERDTreeToggle<CR>
nnoremap <F2> :NERDTreeFind<CR>
nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>
nmap     <C-F>f <Plug>CtrlSFPrompt
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nmap 		 <C-P> :FZF<CR>

let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"
let g:airline_powerline_fonts = 1

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

function! s:TrimTrailingWhitespace() " {{{1
    if &l:modifiable
        " don't lose user position when trimming trailing whitespace
        let s:view = winsaveview()
        try
            silent! keeppatterns keepjumps %s/\s\+$//e
        finally
            call winrestview(s:view)
        endtry
    endif
endfunction " }}}1

autocmd BufWritePre <buffer> call s:TrimTrailingWhitespace()

