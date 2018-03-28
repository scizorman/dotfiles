if &compatible
  set compatible
endif

""""""""""""""""
" Reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

""""""""""""""""
" Environment
let $CACHE = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let $CONFIG = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME
let $DATA = empty($XDG_DATA_HOME) ? expand('$HOME/.local/share') : $XDG_DATA_HOME

if !isdirectory(expand($CACHE))
  call mkdir(expand($CACHE), 'p')
endif


""""""""""""""""
" Load Python3
" let g:python_host_prog = '/usr/bin'
" let g:python3_host_prog = '/usr/local/bin'


""""""""""""""""
" Load dein
let s:dein_dir = expand('$CACHE/dein')
if &runtimepath !~# '/dein.vim'
  let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim'  s:dein_repo_dir
  endif

  execute 'set runtimepath^=' . s:dein_repo_dir
endif

" Load toml files
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#load_toml('$XDG_CONFIG_HOME/nvim/toml/dein.toml')
  call dein#load_toml('$XDG_CONFIG_HOME/nvim/toml/dein_lazy.toml')
  call dein#load_toml('$XDG_CONFIG_HOME/nvim/toml/dein_neo.toml')
  call dein#load_toml('$XDG_CONFIG_HOME/nvim/toml/dein_python.toml')

  call dein#end()
  call dein#save_state()
endif

if has("vim_starting") && dein#check_install()
  call dein#install()
  call map(dein#check_clean(), "delete(v:val, 'rf')")
endif


""""""""""""""""
" Read rc files
function! s:source_rc(rc_file)
  let s:rc_path = expand('$CONFIG/nvim/rc/' . a:rc_file)

  if filereadable(s:rc_path)
    execute 'source' fnameescape(s:rc_path)
  endif
endfunction

call s:source_rc('mappings.rc.vim')
call s:source_rc('options.rc.vim')
call s:source_rc('filetype.rc.vim')


""""""""""""""""
" Colors
set background=dark
syntax on
filetype plugin indent on
colorscheme iceberg
set termguicolors
