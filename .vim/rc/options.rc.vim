" File encoding
if !exists ('g:encodin_set') || !has('nvim')
  set encoding=utf-8
  set fileencoding=utf-8
  let g:encoding_set = 1
endif
scriptencoding utf-8

" Don't create swp file
set writebackup
set nobackup
set noswapfile
set noundofile

" Show column number
set number
set relativenumber

" Long text
set wrap
set textwidth=0
set colorcolumn=256

" Invisible string
set list
" set listchars=tab:»-,extends:»,precedes:«,nbsp:%,eol:$,trail:~

" Don't unload buffer when it is abandones
set hidden

" New load buffer is use open
set switchbuf=useopen

" Tab
set smarttab
set expandtab
set autoindent

" Round indent
set shiftwidth=4
set shiftround

" Space insert by autoindent
set tabstop=4
set scrolloff=3

" Splitting a window will put the new window.
set splitbelow
set splitright

" Current window
set winwidth=30
set winheight=1

" Command line window
set cmdwinheight=5

" No equal wiindow size
set noequalalways

" Adjust window size
set previewheight=8
set helpheight=12

" Show tab line
set showtabline=2

" Search
set ignorecase
set smartcase
set incsearch
set hlsearch
" Replace incremental
if exists('&inccommand')
  set inccommand=split
endif

" Show clipboard with system
set clipboard+=unnamedplus

" Use extend grep
if executable('rg')
  let &grepprg = 'rg --vimgrep --hidden'
  set grepformat=%f:%l%c:%m
elseif executable('pt')
  let &grepprg = 'pt --nocolor --nogroup --column'
  set grepformat=%f:%l%c:%m
endif

" For input multibyte chars
set ttimeout
set ttimeoutlen=50

" Save undo history
if has('persistent_undo')
  set undodir=./.vimundo,$HOME/.vimundo
  augroup vimrc-undofile
    autocmd!
    autocmd BufReadPre ~/* setlocal undofile
  augroup END
endif

" jq command
command! -nargs=? Jq call s:Jq(<f-args>)
function! s:Jq(...)
  if 0 == a:0
    let l:arg = "."
  else
    let l:arg = a:1
  endif
  execute "%! jq \"" . l:arg . "\""
endfunction

" Number of characters to apply syntax per line
set synmaxcol=200

" Reload change file
augroup vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END

" Disable sql omni complete
let g:omni_sql_no_default_maps = 1
