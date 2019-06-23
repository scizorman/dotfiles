" setting of the encoding to use for a save and reading
if misc#is_starting() && &encoding !=# 'utf-8'
  if misc#is_windows() && !misc#is_gui()
    set encoding=cp932
  else
    set encoding=utf-8
  endif
endif

" build encodings
let &fileencodings = join([
      \ 'ucs-bom', 'iso-2022-jp-3', 'utf-8', 'euc-jp', 'cp932',
      \ ])

" setting of terminal encoding
if !misc#is_gui() && misc#is_windows()
  set termencoding=cp932
endif

if has('multi_byte_ime')
  set iminsert=0 " use :lmap or IM in Insert mode
  set imsearch=0 " use :lmap or IM when typing a search pattern
endif

" use English interface
language message C

" setting of <Leader>
nnoremap <Space> <Nop>
let g:mapleader = "\<Space>"
let g:maplocalleader = "\\"

" exchange path separator (only Windows)
if misc#is_windows()
  set shellslsah " use forward slash for shell file names
endif

" setting of 'dein.vim'
if !isdirectory(expand($XDG_CACHE_HOME))
  call mkdir(expand($XDG_CACHE_HOME), 'p')
endif

if &runtimepath !~# '/dein.vim'
  let s:dein_dir = expand($XDG_CACHE_HOME)
        \ . '/dein/repos/github.com/Shougo/dein.vim'
  if !isdirectory(s:dein_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
  endif

  execute 'set runtimepath^=' . substitute(
        \ fnamemodify(s:dein_dir, ':p'), '/$', '', '')
endif


set packpath= " list of directories used for package (disable)

if misc#is_gui()
  " GUI: which components and options are used
  "   M: The system menu "$VIMRUNTIME/menu.vim" is not sourced.
  "      NOTE: This flag must be added in the vimrc file, before switching on
  "            syntax or filetype recognition (when the gvimrc file is sourced
  "            the system menu has already been loaded; the :syntax on and
  "            :filetype on commands load the menu too).
  "   c: Use console dialogs instead of popup dialogs for simple choices.
  set guioptions=Mc " GUI: which components and options are used
endif

" disable default plugins
let g:loaded_2html_plugin    = 1
let g:loaded_logiPat         = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_gzip            = 1
let g:loaded_man             = 1
let g:loaded_matchit         = 1
let g:loaded_netrw           = 1
let g:loaded_netrwPlugin     = 1
let g:loaded_tarPlugin       = 1
let g:loaded_zip             = 1
let g:loaded_zipPlugin       = 1
