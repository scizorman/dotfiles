" Use English interface.
language message C

" <Leader>
nnoremap <Space> <Nop>
let g:mapleader = "\<Space>"
let g:maplocalleader = "\\"

" Setting of 'dein.vim'.
if !isdirectory(expand($XDG_CACHE_HOME))
  call mkdir(expand($XDG_CACHE_HOME), 'p')
endif

let s:dein_dir = finddir('dein.vim', '.;')
if s:dein_dir != '' || &runtimepath !~ '/dein.vim'
  if s:dein_dir == '' && &runtimepath !~ '/dein.vim'
    let s:dein_dir = expand('$XDG_CACHE_HOME/dein')
          \ . '/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
    endif
  endif

  execute 'set runtimepath^=' . substitute(
        \ fnamemodify(s:dein_dir, ':p'), '/$', '', '')
endif

if &runtimepath !~# '/dein.vim'
  let s:dein_dir = expand($XDG_CACHE_HOME)
        \ . '/dein/repos/github.com/Shougo/dein.vim'
  if !isdirectory(s:dein_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
  endif

  execute 'set runtimepath^=' . substitute(
        \ fnamemodify(s:dein_dir, ':p'), '/$', '', '',
	      \ )
endif

" Disable default plugins.
" disable menu.vim
if has('gui_running')
  " GUI: which components and options are used
  "   M: The system menu "$VIMRUNTIME/menu.vim" is not sources.
  "      NOTE: This flag mut be added in the vimrc file, before switching on
  "            syntax or filetype recognition (when the gvimrc file is sourced
  "            the system menu has already been loaded; the :syntax on and
  "            :filetype on commands load the menu too).
  "   c: Use console dialogs instead of popup dialogs for simple choices.
  set guioptions=Mc
endif

let g:loaded_2html_plugin      = 1
let g:loaded_logiPat           = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_gzip              = 1
let g:loaded_man               = 1
let g:loaded_matchit           = 1
let g:loaded_matchparen        = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_rrhelper          = 1
let g:loaded_shada_plugin      = 1
let g:loaded_spellfile_plugin  = 1
let g:loaded_tarPlugin         = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_zipPlugin         = 1
