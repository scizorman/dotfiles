" File encoding
if !exsits ('g:encoding_set') || !has('nvim')
    set encoding=utf-8
    set fileencodings=utf-8,sjis,iso-2022-jp,cp932,euc-jp
    set fileencoding=utf-8
    let g:encoding_set=1
endif
scriptencoding utf-8

" Swap file (don't create)
set writebackup
set nobackup
set noswapfile
set noundofile

" Show column number
set number

" Long text
set wrap
set textwidth=0
set colorcolumn=256

" Invisible string
set list
set listchars=tab:»-,extends:»,precedes:«,nbsp:%,eol:$,trail:~

" Don't unload buffer when it is abandones
set hidden

" New load buffer is use open
set switchbuf=useopen

" Tab
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set softtabstop=4
set autoindent

" Edit
set smartindent
set showmatch
set matchtime=3
set backspace=indent,eol,start
set virtualedit+=block
set modeline
set modeline=5

" Search
set ignorecase
set smartcase
set incsearch
set wrapscan
set infercase
set hlsearch

" Share clipborad with system
set clipboard+=unnamedplus

" Use extend grep
if executable('rg')
    let &grepprg = 'rg --vimgrep --hidden'
    set grepformat=%f:%l:%c:%m
elseif executable('pt')
    let &grepprg = 'pt --nocolor --nogroup --column'
    set grepformat=%f:%l:%c:%m
endif

" Show quickfix after grepcmd
augroup GrepCmd
    autocmd!
    autocmd QuickFixCmdPost vim,grep,make if len(getqflist()) != 0 | cwindow | endif
augroup END

" For input multibyte chars
set ttimeout
set ttimeoutlen=50

" Save undo history
if has('persistent_undo')
  set undodir=./.vimundo,~/.vimundo
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
