" <Leader> mapping
let g:mapleader = ','
let g:maplocalleader = '\'

" Editing .vimrc
nnoremap <LocalLeader>e :tabnew $HOME/.vimrc<CR>

" Reload .vimrc
nnoremap <LocalLeader>r :source $HOME/.vimrc<CR>

" Exit from INSERT
inoremap <silent> jj <ESC>

" Highlight
nnoremap <silent> <ESC> <ESC>:noh<CR>
" NOTE: You must set 'hlsearch'
nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>

" Multi line move
noremap <silent> k gk
noremap <silent> j gj
noremap <silent> gk k
noremap <silent> gj j
noremap <silent> <Up> gk
noremap <silent> <Down> gj

" Skip move
noremap H <nop>
noremap L <Nop>
noremap H ^
noremap L $

" Change tab width
nnoremap <silent> ts2 :<C-u>setl shiftwidth=2 softtabstop=2<CR>
nnoremap <silent> ts4 :<C-u>setl shiftwidth=4 softtabstop=4<CR>
nnoremap <silent> ts8 :<C-u>setl shiftwidth=8 softtabstop=8<CR>

" Disable close window
nnoremap <C-w>c <Nop>

" Search yank string
nnoremap <Space>sy /<C-r>"<CR>

" Register
nnoremap x "_x
vnoremap x "_x
nnoremap X "_X
vnoremap X "_X
nnoremap s "_s
vnoremap s "_s
nnoremap S "_S
vnoremap S "_S

nnoremap Y y$
