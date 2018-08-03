" Tab setting for file type.
augroup MyTabStop
    autocmd!
    autocmd BufNewFile,BufRead *.py setlocal tabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.go setlocal tabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.html setlocal tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.css setlocal tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.scss setlocal tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.js setlocal tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.{c,cpp,h} setlocal tabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead Makefile setlocal noexpandtab 
    autocmd BufNewFile,BufRead *.sh setlocal tabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.vim setlocal tabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.toml setlocal tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.json setlocal tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.yaml setlocal tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.md setlocal tabstop=2 shiftwidth=2
augroup END

augroup MyGitSpellCheck
    autocmd!
    autocmd Filetype gitcommit setlocal spell
augroup END
