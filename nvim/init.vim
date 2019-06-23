" Initialize `GlobalAutoCmd`
augroup GlobalAutoCmd
  autocmd!
  autocmd FileType,Syntax,BufNewFile,BufNew,BufRead *?
       \ call misc#on_filetype()
  autocmd CursorHold toml syntax sync minlines=300
augroup END

" Python provider
let g:python_host_prog = $PYENV_ROOT . '/shims/python2'
let g:python3_host_prog = $PYENV_ROOT . '/shims/python3'

" Ruby provider
let g:loaded_ruby_provider = 0

" Node.js provider
let g:loaded_node_provider = 0

if misc#is_starting()
  call misc#source_rc('init.rc.vim')
endif

call misc#source_rc('dein.rc.vim')

if misc#is_starting() && !empty(argv())
  call misc#on_filetype()
endif

if !misc#is_starting()
  call dein#call_hook('source')
  call dein#call_hook('post_source')
endif

call misc#source_rc('encoding.rc.vim')

call misc#source_rc('options.rc.vim')

call misc#source_rc('mappings.rc.vim')

" GlobalAutoCmd
" Global
autocmd GlobalAutoCmd BufWinEnter *
     \ if line("'\'") > 1 && line("'\'") <= line("$") && &filetype != 'gitcommit' |
     \ execute "silent! keepjumps normal! g`\"zz"

" Vim
" Gautocmd BufWritePost $MYVIMRC,*.vim nested silent! source $MYVIMRC | setlocal colorcolumn=79

" Neosnippet
autocmd GlobalAutoCmd InsertLeave * NeoSnippetClearMarkers

autocmd GlobalAutoCmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif


" NOTO: Must be written at the last
" See :help secure
set secure
