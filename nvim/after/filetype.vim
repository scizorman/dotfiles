if exists('did_load_filetypes_userafter')
  finish
endif
let g:did_load_filetypes_userafter = 1

augroup filetypedetect
  autocmd! BufNewFile,BufRead LICENSE setlocal filetype=license
  autocmd! BufNewFile,BufRead *.conf setlocal filetype=conf
  autocmd! BufNewFile,BufRead *.es6 setlocal filetype=javascript
  autocmd! BufNewFile,BufRead *.mm setlocal filetype=objcpp
  autocmd! BufNewFile,BufRead *[Dd]ockerfile\(.vim\)\@!* setlocal filetype=dockerfile
  autocmd! BufNewFile,BufRead **/c++/**/* setlocal filetype=cpp
  autocmd! BufNewFile,BufRead **/zsh/**/* setlocal filetype=zsh
  autocmd! BufNewFile,BufRead .clang-format setlocal filetype=yaml
augroup END
