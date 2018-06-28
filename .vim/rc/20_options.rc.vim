" 
" 24. Multi-byte characters
"
" NOTE: Write at the top.
"
" encode: Character encoding used in Vim: 'latin1', 'utf-8', 'euc-jp', 'big5', etc.
" fileencoding: Character encoding for the current file.
" fileencodings: Automatically detected character encodings.
if !exists ('g:encoding_set') || !has('nvim')
  set encoding=utf-8
  set fileencoding=utf-8
  set fileencodings=utf-8,sjis,iso2022-jp,cp932,euc-jp
  let g:encoding_set=1
endif
scriptencoding utf-8


"
" 1. Important (None)
"


"
" 2. Moving around, searching and patterns
"
" Show match for partly typed search command
set incsearch

" Ignore case when using a search patterns.
set ignorecase

" Override 'ignorecase' when pattern has upper case characters.
set smartcase

" Optional: Replace incremental.
if exists('&inccommand')
  set inccommand=split
endif


"
" 3. Tags (None)
"


"
" 4. Displaying text
" 
" Number of screen lines to show around the cursor.
set scrolloff=3

" Long lines wrap
set wrap

" Show <TAB> as ^I and end-of-line as $
set list

" List of strings used for list mode.
" set listchars=tab:»-,extends:»,precedes:«,nbsp:%,eol:$,trail:~
"
" Show the line number for each line.
set number

" Show the relative line number for each line.
set relativenumber


"
" 5. Syntax, Highlighting and Spelling
"
" The background color brightness.
set background=dark

" Maximum column to look for syntax items
set synmaxcol=256

" Highlight all matches for the last used search pattern.
set hlsearch

" Columns to highlight.
set colorcolumn=256


" 
" 6. Multiple windows
"
" Make all windows the same size when adding/removing windows.
set noequalalways " Disabled

" Minimal number of lines used for the current window.
set winheight=1

" Minimal number of columns used for the current window.
set winwidth=30

" Initial height of the help window.
set helpheight=12

" Default height for the preview window.
set previewheight=8

" Don't unload a buffer when no longer shown in a window.
set hidden

" 'useopen' and/or 'splist'; which window to use when jumping to a buffer.
set switchbuf=useopen

" A new window is put below the current one.
set splitbelow

" A new window is put right the current one.
set splitright


"
" 7. Multiple tab pages.
"
" 0, 1, or 2; when to use a tab pags line.
set showtabline=2


" 
" 8. Terminal (None)
"


"
" 9. Using the mouse. (None)
"


"
" 10. Printing (None)
"


"
" 11. Message and info (None)
"


"
" 12. Selecting text
"
" 'unnamed' to use the * register like unnamed register
set clipboard+=unnamedplus


"
" 12. Editing text
"
" Automatically save and restore undo history.
set noundofile " Disable

" List of directoried for undo files.
if has('persistent_undo')
  set undodir=./.vimundo,~/.vimundo
  augroup vimrc-undofile
    autocmd!
    autocmd BufReadPre ~/* setlocal undofile
  augroup END
endif

" Line length above which to break a line.
set textwidth=0


" 
" 14. Tabs and Indenting.
"
" Number of spaces a <TAB> in the next stands for
set tabstop=4

" Number of spaces used for each step of (auto)indent
set shiftwidth=4

" A <TAB> in an indent inserts 'shiftwidth' spaces.
set smarttab

" Round to 'shiftwidth' in Insert mode.
set shiftround

" Expand <TAB> to spaces in Insert mode.
set expandtab

" Automatically set the indent of a new line.
set autoindent


" 
" 15. Folding あとで編集
"


" 
" 16. Diff mode (None)
"


" 
" 17. Mapping
"
" Allow timing out halfway into a key code.
set ttimeout

" Time in msec for 'ttimeout'.
set ttimeoutlen=50


" 
" 18. Reading and writing files
"
" Write a backup file before overwriting a file.
set writebackup

" Keep a backup after overwriting a file.
set nobackup " Disable


" 
" 19. The swap file
"
" Use a swap file for this buffer.
set noswapfile " Disable


" 
" 20. Command line editing
"
" Height of the command-line window.
set cmdwinheight=5


" 
" 21. Executing external commands (None)
"


" 
" 22. Running make and jumping to errors
"
" grepprg: Program used for the ':grep' command.
" grepformat: List of formats for output of 'grepprg'.
if executable('rg')
  let &grepprg = 'rg --vimgrep --hidden'
  set grepformat=%f:%l%c:%m
elseif executable('pt')
  let &grepprg = 'pt --nocolor --nogroup --column'
  set grepformat=%f:%l%c:%m
endif


" 
" 23. Language specific (None)
"


" 
" 24. Multi-byte characters
"
" NOTE: Write at the top.


" 
" 25. Various (None)
"


"
" Etc.
"
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

" Disable sql omni complete
let g:omni_sql_no_default_maps = 1
