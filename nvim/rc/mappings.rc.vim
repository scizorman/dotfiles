" Change leader mapping
" let g:mapleader = ','

" Editing .vimrc
" nnoremap <Space>e :tabnew $HOME/.vimrc<CR>

" Reload .vimrc
" nnoremap <Space>s :source $HOME/.vimrc<CR>

inoremap <silent> jj <ESC>

nnoremap <silent> <ESC> <ESC>:noh<CR>>

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
