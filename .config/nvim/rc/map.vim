" Define <Leader> and <LocalLeader>
let g:mapleader = '<Space>'
let g:maplocalleader = '\'

" Editing .vimrc
" nnoremap <LocalLeader>e :tabnew $HOME/.vimrc<CR>
nnoremap <LocalLeader>e :tabnew g:config.path.vimrc<CR>

" Reload .vimrc
" nnoremap <LocalLeader>r :source $HOME/.vimrc<CR>
nnoremap <LocalLeader>r :source g:config.path.vimrc<CR>

" Exit from INSERT
inoremap <silent> jj <ESC>

" Highlight
nnoremap <silent> <ESC> <ESC>:noh<CR>
" NOTE: You must set 'hlsearch'
" nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>

" Multi line move
noremap <silent> k gk
noremap <silent> j gj
noremap <silent> gk k
noremap <silent> gj j
noremap <silent> <Up> gk
noremap <silent> <Down> gj

" Cursor movement of command-line
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-d> <Del>


" Search yank string
" nnoremap <Space>sy /<C-r>"<CR>

" Register
nnoremap x "_x
vnoremap x "_x
nnoremap X "_X
vnoremap X "_X
" nnoremap s "_s
" vnoremap s "_s
nnoremap S "_S
vnoremap S "_S

nnoremap Y y$
