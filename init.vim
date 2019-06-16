function! s:source_rc(path, ...) abort
  let l:use_global = get(a:000, 0, !misc#is_starting())
  let l:abspath = resolve(expand($XDG_CONFIG_HOME . '/nvim/rc/' . a:path))

  if !use_global
    execute 'source' fnameescape(l:abspath)
    return
  endif

  " substitute all 'set' to 'setglobal'
  let l:content = map(readfile(l:abspath),
        \ 'substitute(v:val, "^\\W*\\zsset\\ze\\W", "setglobal", "")')
  let l:tempfile = tempname()
  try
    call writefile(l:content, l:tempfile)
    execute 'source' fnameescape(l:tempfile)
  finally
    if filereadable(l:tempfile)
      call delete(l:tempfile)
    endif
  endtry
endfunction

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

call s:source_rc('encoding.rc.vim')
call s:source_rc('options.rc.vim')
call s:source_rc('mappings.rc.vim')

call s:source_rc('dein.rc.vim')

if misc#is_starting() && !empty(argv())
  call misc#on_filetype()
endif

if !misc#is_starting()
  call dein#call_hook('source')
  call dein#call_hook('post_source')
endif

" GlobalAutoCmd
" Global
autocmd GlobalAutoCmd BufWinEnter *
      \ if line("'\'") > 1 && line("'\'") <= line("$") && &filetype != 'gitcommit' |
      \ execute "silent! keepjumps normal! g`\"zz"

" Go
autocmd GlobalAutoCmd FileType ia64 let b:caw_oneline_comment = '//' | let b:caw_wrap_oneline_comment = ['/*', '*/']

" Vim
" Gautocmd BufWritePost $MYVIMRC,*.vim nested silent! source $MYVIMRC | setlocal colorcolumn=79

" Neosnippet
autocmd GlobalAutoCmd InsertLeave * NeoSnippetClearMarkers

autocmd GlobalAutoCmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif


" NOTO: Must be written at the last
" See :help secure
set secure
