" Search
set ignorecase " ignore case in search patterns
set smartcase  " no ignore case when pattern has uppercase
set wrapscan   " searches wrap around the end of the file


" Edit
set expandtab     " use spaces when <Tab> is inserted
set smarttab      " use 'shiftwidth' when inserting <Tab>
set tabstop=2     " number of spaces that <Tab> in file uses
set softtabstop=2 " number of spaces that <Tab> uses while editing
set shiftwidth=2  " number of spaces to use for (auto)indent step
set shiftround    " round indent to multiple of shiftwidth

set autoindent  " take indent for new line from previous line
set smartindent " smart autoindenting for C programs

set modelines=0 " number of lines checked for modelines
set nomodeline  " recognize modelines at start or end of file (disable)

autocmd MyAutoCmd BufRead,BufWritePost *.txt setlocal modelines=5 modeline

set nofoldenable " set to display all folds open (disable)

set timeout        " time out on mappings and key codes
set ttimeout       " time out on mappings
set timeoutlen=500 " time out time in milliseconds
set ttimeoutlen=5  " time out time for key codes in milliseconds

set virtualedit=block " when to use virtual editing
                      " (allow virtual editing in Visual block mode)

set keywordprg=:help " program to use for the 'K' command


" View
set list " show <Tab> and <EOL>

set number         " print the line number in front of each line
set relativenumber " show relative line number in front of each line

set colorcolumn=120 " columns to highlight

set cmdheight=2 " number of lines to use for the command-line

set linebreak         " wrap long lines at a blank
set showbreak=\       " string to use at the start of wrapped lines
set breakat=\ \ ;:,!? " characters that may cause a line breakcharacters that may cause a line break

if exists('+breakindent')
  set breakindent " wrapped line repeats indent
  set wrap        " long lines wrap and continue on the next line
else
  set nowrap
endif

set showtabline=2 " tells when the tab pages line is displayed (always)
set showmode      " message on status line to show current mode

" list of flags, reduce length of messages
"   a: all of the above abbreviation
"   T: truncate file message in the middle if they are too long to fit on the
"      command line. '...' will appear in the middle.
"      Ignored in Ex mode.
"   I: don't give the intro message when starting Vim :intro.
set shortmess=aTI

set splitbelow " new window from split is below the current one
set splitright " new window is put right of the current one

set winwidth=30 " minimal number of columns for current window
set winheight=1 " minimum number of lines for the current window

set cmdwinheight=5 " height of the command-line window

" set noequalalways " windows are automatically made the same size (disable)
"
set previewheight=15 " height of the preview window
set helpheight=10    " minimum height of a new help window

set display=lastline " list of flags for how to display text

set clipboard=unnamedplus " use the clipboard as the unnamed register



" etc.
set hidden " don't unload buffer when it is abandoned

set grepprg=grep\ -inH " program to use for ':grep'

set complete=.          " specify how Insert mode completion works
                        " (don't complete from other buffers)
set completeopt=menuone " options for Insert mode completion
                        " (use a popup menu to show the possible completions)
set pumheight=20        " maximum height of the popup menu

set showfulltag       " show full tag pattern when completing tag

set conceallevel=2    " whether concealable text is shown or hidden
                      " (concealed text is completely hidden unless it has a
                      "  custom replacement character defined (see :syn-cchar))
set concealcursor=niv " whether concealable text is hidden in cursor line
                      " (n: Normal mode, i: Insert mode, v: Visual mode)

set updatetime=100 " after this many milliseconds flush swap file

set undofile " save undo information in a file

set report=0 " threshold for reporting nr. of lines changed (always)

set helplang=en " preferred help languages (English)

set mouse=n " enable the use of mouse clicks (Normal mode)
