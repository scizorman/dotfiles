" Change leader mapping
" let g:mapleader = ','

" Editing .vimrc
" nnoremap <Space>e :tabnew $HOME/.vimrc<CR>

" Reload .vimrc
" nnoremap <Space>s :source $HOME/.vimrc<CR>

inoremap <silent> jj <ESC>

nnoremap <silent> <ESC> <ESC>:noh<CR>>

" Multi line move
noremap k gk
noremap j gj
noremap gk k
noremap gj j
noremap <Up> gk
noremap <Down> gj
noremap <S-h> ^
noremap <S-l> $
noremap <S-j> }
noremap <S-k> {

" Fix type miss
inoremap <C-t> <Esc><Left>"zx"zpa

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

" Highlight
nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>
