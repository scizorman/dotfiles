""""""""""""""""
" Reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

""""""""""""""""
" Environment
let $CACHE = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME

if !isdirectory(expand($CACHE))
  call mkdir(expand($CACHE), 'p')
endif

""""""""""""""""
" Load Python
function! s:pick_executable(pathspecs) abort
  for s:pathspec in filter(a:pathspecs, '!empty(v:val)')
    for s:path in reverse(glob(s:pathspec, 0, 1))
      if executable(s:path)
        return s:path
      endif
    endfor
  endfor
  return ''
endfunction

if has('nvim')
  let g:python_host_prog = s:pick_executable(
    \ ['/usr/local/bin/python2', '/usr/bin/python2', '/bin/python2']
  \ )
  let g:python3_host_prog = s:pick_executable(
    \ ['/usr/local/bin/python3', '/usr/bin/python3', '/bin/python3']
  \ )
endif

""""""""""""""""
" Load Dein
let s:dein_dir = expand('$CACHE/dein')
if &runtimepath !~# '/dein.vim'
  let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif

  execute 'set runtimepath^=' . s:dein_repo_dir
endif

""""""""""""""""
" Load rc files
let s:rc_path = has('nvim') ? expand('$XDG_CONFIG_HOME/nvim/rc/**.rc.vim') : expand('$HOME/.vim/rc/**.rc.vim')

for s:rc_file in split(s:rc_path, '\n')
  if filereadable(s:rc_file)
    execute 'source' fnameescape(s:rc_file)
  endif
endfor

""""""""""""""""
" Colors
set t_Co=256
set background=dark
syntax on
filetype plugin indent on
colorscheme iceberg
