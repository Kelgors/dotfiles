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
