"
" 1. Important
" Note: None
"


"
" 2. Moving around, searching and patterns
"
" List of flags specifying which commands wrap to another line
set whichwrap=b,s,h,l,<,>,[,]

" Many jump commands move the cursor to the first non-blank
set nostartofline " Disable

" Search commands wrap around the end of the buffer
set wrapscan

" Show match for partly typed search command
set incsearch

" Ignore case when using a search patterns
set ignorecase

" Override 'ignorecase' when pattern has upper case characters
set smartcase

" Optional: Replace incremental
if exists('&inccommand')
    set inccommand=split
endif


"
" 3. Tags
" Note: None
"


"
" 4. Displaying text
" 
" Number of screen lines to show around the cursor
set scrolloff=3

" Long lines wrap
set wrap

if has('patch-7.4.3')
  " Preserve indentation in wrapped text
  set breakindent
endif


" Number of lines used for the command-line
set cmdheight=2

" Don't redraw while executing macros
set lazyredraw

" Show <TAB> as ^I and end-of-line as $
set list

" List of strings used for list mode
" set listchars=tab:»-,extends:»,precedes:«,nbsp:%,eol:$,trail:~
"
" Show the line number for each line
set number

" Show the relative line number for each line
set relativenumber


"
" 5. Syntax, Highlighting and Spelling
"
" The background color brightness
set background=dark

" Maximum column to look for syntax items
set synmaxcol=256

" Highlight all matches for the last used search pattern
set hlsearch

" Use GUI colors for the terminal
set termguicolors
if has('nvim')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" Columns to highlight
set colorcolumn=256


" 
" 6. Multiple windows
"
" 0, 1, or 2; when to use a status line for the last window
set laststatus=2

" Make all windows the same size when adding/removing windows
set noequalalways " Disabled

" Minimal number of lines used for the current window
set winheight=1

" Minimal number of columns used for the current window
set winwidth=30

" Initial height of the help window
set helpheight=12

" Default height for the preview window
set previewheight=8

" Don't unload a buffer when no longer shown in a window
set hidden

" 'useopen' and/or 'splist'; which window to use when jumping to a buffer
set switchbuf=useopen,usetab,newtab

" A new window is put below the current one
set splitbelow

" A new window is put right the current one
set splitright


"
" 7. Multiple tab pages
"
" 0, 1, or 2; when to use a tab pages line
set showtabline=2


" 
" 8. Terminal
"
" Show info in the window line
set notitle " Disable


"
" 9. Using the mouse 
" Note: None
"


"
" 10. Printing
" Note: None
"


"
" 11. Message and info
" Note: None
"
" Show (partial) command keys in the status line
set showcmd

" Display the current mode in the status line
set showmode

" Show cursor position below each window
set ruler

" Alternate format to be used for the ruler
set rulerformat=%m%r%=%l/%L

" Use a visual bell instead of beeping
set novisualbell


"
" 12. Selecting text
"
if has('clipboard')
  " 'unnamed' to use the * register like unnamed register
  set clipboard=unnamed
endif


"
" 13. Editing text
"
if has('persistent_undo')
  " Automatically save and restore undo history
  set undofile

  " List of directoried for undo files
  let &undodir = g:config.path.vim . '/undo'
  set undodir=./.vimundo,~/.vimundo
  call misc#mkdir(&undodir)
endif

" Line length above which to break a line
set textwidth=79

" Specifies what <BS>, CTRL-W, etc
set backspace=indent,eol,start

" List of flags that tell how automatic formatting works
" set formatoptions&
" set formatoptions-=t
" set formatoptions-=c
" set formatoptions-=r
" set formatoptions-=o
" set formatoptions-=v
" set formatoptions+=l

" Maximum height of the popup menu
set pumheight=10

" When inserting a bracket, briefly jump to its match
set showmatch

" Tenth of a second to show a match for 'showmatch'
set matchtime=1

" List of pairs that match for the '%' command
set matchpairs& matchpairs+=<:>

" 'alpha', 'octal' and/or 'hex'; number formats recognized for CTRL-A and
" CTRL-X commands
set nrformats=alpha,hex


" 
" 14. Tabs and Indenting
"
" Number of spaces a <TAB> in the next stands for
set tabstop=4

" Number of spaces used for each step of (auto)indent
set shiftwidth=4

" A <TAB> in an indent inserts 'shiftwidth' spaces
set smarttab

" Expand <TAB> to spaces in Insert mode
set expandtab

" Automatically set the indent of a new line
set autoindent

" Do clever autoindenting
set smartindent


" 
" 15. Folding
"
" Set to display all folds open
set foldenable

" Folds with a level higher than this number will be closed
set foldlevel=0


" 
" 16. Diff mode
" Note: None
"


" 
" 17. Mapping
" Note: None
"


" 
" 18. Reading and writing files
"
" EOL format: 'dos', 'unix' or 'mac'
set fileformat=unix

" List of file formats to look for when editing a file
set fileformats=unix,dos,mac

" Automatically write a file when leaving a modified buffer
set autowrite

" Automatically read a file when it was modified outside of vim
set autoread


" 
" 19. The swap file
" Note: None
"


" 
" 20. Command line editing
"
" How many command lines are remembered
set history=10000

" Specifies how command line completion works
set wildmode=longest,full

" List of patterns to ignore files for file name completion
set wildignore&
set wildignore=.git,.hg,.svn
set wildignore+=*.jpg,*.jpeg,*.bmp,*.gif,*.png
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.so,*.out,*.class
set wildignore+=*.swp,*.swo,*.swn
set wildignore+=*.DS_Store

" Command-line completion shows a list of matches
set wildmenu

" Height of the command-line window
set cmdwinheight=5

" 
" 21. Executing external commands
"
" Program used for 'K' command
set keywordprg=:help


" 
" 22. Running make and jumping to errors
" Note: None
"


" 
" 23. Language specific
"
" In Insert mode: 1: use :lmap; 2: use IM; 0:neither
set iminsert=0

" Entering a search pattern: 1: user :lmap; 2: use IM; 0: neither
set imsearch=0


" 
" 24. Multi-byte characters
"
" Character encoding used in Vim
set encoding=utf-8

" Character encoding for the current file
set fileencoding=utf-8

" Automatically detected character encodings
set fileencodings=utf-8,iso-2022-jp,euc-jp,ucs-2le,ucs-2,cp932

" Width of ambiguous width characters
set ambiwidth=single


" 
" 25. Various
"
set virtualedit& virtualedit+=block
