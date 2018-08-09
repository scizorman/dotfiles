" What to do with Unicode chars of ambiguous width
set ambiwidth

" Take indent for new line from previous line
set autoindent

" Read file when changed outside of vim
set autoread

" Automatically write file if changed
set autowrite

" Keep backup file after overwriting a file
set backup

" List of directories for the backup file
let &backupdir = g:config.path.backup
set backupdir

" How to do indenting when 'cindent' is set
" set cinoptions+=:0,g0,N-1,m1

" Use the clipboard as the unnamed register
set clipboard=unnamed,unnamedplus

" Number of lines to use for the command-line
set cmdheight=2

" Columns to highlight
set colorcolumn=79

" List of directory names for the swap file
let &directory = g:config.path.swap
set directory

" Use spaces when <Tab> is inserted
set expandtab

" Width of the column used to indicate folds
set foldcolumn=0

" Folding type
set foldmethod=indent

" Maximum fold depth
set foldnestmax=1

" How automatic formatting is to be done
set formatoptions+=c " Auto-wrap comments using textwidth
set formatoptions+=j " Delete comment character when joining commented lines
set formatoptions+=l " Do not wrap lines that have been longer when starting insert mode already
set formatoptions+=n " Recognize numbered lists
set formatoptions+=q " Allow formatting of comments with 'gq'
set formatoptions+=r " Insert comment leader after hitting <Enter>
set formatoptions+=t " Auto-wrap text using textwidth

" Preferred help languages
set helplang& helplang=en

" Don't unload buffer when it is abandoned
set hidden

" Highlight matches with last search pattern
set hlsearch

" Number of command-lines that are remembered
set history=10000

" Ignore case in search patterns
set ignorecase

" Highlight match while typing search pattern
set incsearch

" Tells when last window has status lines
set laststatus=2

" Wrap long lines at a blank
set linebreak

" Tenths of a second to show matching paren
set matchtime=0

" Maximum memory (in Kbyte) used for pattern search
set maxmempattern=2000000

" Recognize modelines at start or end of file
set modeline

" Number of lines checked for modelines
set modelines=2

" Enable the use of mouse clicks
set mouse=a

" Print the line number in front of each line
set number

" Maximum height of the popup menu
set pumheight=10

" Default regexp engine to use
set regexpengine=2

" Show relative line number in front of each line
set relativenumber

" Show cursor line and column in the status line
set ruler

" Minimum number of lines to scroll
set scrolljump=1

" Minimum number of lines above and below cursor
set scrolloff=3

" Round indent to multiple of shiftwidth
set shiftround

" Number of spaces to use for (auto)indent step
set shiftwidth=2

" Show full tag pattern when completing tag
set showfulltag

" Briefly jump to matching bracket if insert one
set showmatch

" Tells when the tab pages line is displayed
set showtabline=2

" Minimum number of columns to left and right of cursor
set sidescrolloff=3

" No ignore case when pattern has uppercase
set smartcase

" Smart autoindenting for C programs
set smartindent

" Use 'shiftwidth' when inserting <Tab>
" set smarttab

" Number of spaces that <Tab> uses while editing
set softtabstop=2

" New window from split is below the current one
set splitbelow

" New window is put right of the current one
set splitright

" Sets behavior when switching to another buffer
set switchbuf=useopen

" Maximum column to find syntax items
set synmaxcol=0

" Number of spaces that <Tab> in file uses
set tabstop=2

" List of file names used by the tag command
set tags=./tags;

" Uses 24-bit color
set termguicolors

" Maximum width of text that is being inserted
set textwidth=0

" Time out on mappings and key codes
set timeout

" Time out time in milliseconds
set timeoutlen=500

" Time out on mappings
set ttimeout

" Time out time for key codes in milliseconds
set ttimeoutlen=5

" Where to store undo files
let &undodir = g:config.path.undo
set undodir

" Save undo information in a file
set undofile

" Maximum number of changes that can be undone
set undolevels=10000

" After this many milliseconds flush swap file
set updatetime=500

" Files matching these patterns are not completed
set wildignore+=*.jpg,*.jpeg,*.bmp,*.gif,*.png           " image
set wildignore+=*.manifest                               " gb
set wildignore+=*.o,*.obj,*.exe,*.dll,*.so,*.out,*.class " compiler
set wildignore+=*.swp,*.swo,*.swn                        " vim
set wildignore+=*.ycm_extra_conf.py,*.ycm_extra_conf.pyc " YCM
set wildignore+=*/.git,*/.hg,*/.svn                      " vcs
set wildignore+=tags,*.tags                              " tags

" Mode for 'wildchar' command-line expansion
set wildmode=longest,list:full

" Long lines wrap and continue on the next line
set wrap

" Searches wrap around the end of the file
set wrapscan


"
" Disable options
"
" Change directory to the file in the current window
set noautochdir

" Ring the bell for error messages
set noerrorbells

" Set to display all folds open
set nofoldenable

" Two spaces after a period with a join command
set nojoinspaces

" Don't redraw while executing macros
set nolazyredraw

" Show (partial) command in status line
set noshowcmd

" Commands move cursor to first non-blank in line
set nostartofline

" Whether to use a swap file for a buffer
set noswapfile

" Let Vim set the title of the window
set notitle

" Use visual bell instead of beeping
set novisualbell

" Make a backup before overwriting a file
set nowritebackup
