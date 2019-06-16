" Insert mode
" escape Insert mode
inoremap jj <Esc>
" write 'j'
inoremap j<Space> j
" insert tab
inoremap <C-t> <C-v><Tab>

" Command-line mode
" next char
cnoremap <C-f> <Right>
" previous char
cnoremap <C-b> <Left>
" delete char
cnoremap <C-d> <Del>
" move to head
cnoremap <C-a> <Home>
" move to end
cnoremap <C-e> <End>
" previous history
cnoremap <C-p> <Up>
" next history
cnoremap <C-n> <Down>
" paste
cnoremap <C-y> <C-r>*
" exit
cnoremap <C-g> <C-c>

" Define 'Leader'
noremap <Space> <Nop>
let g:mapleader = "\<Space>"
let g:maplocalleader = "\\"

nnoremap <silent><Esc> <Esc>:noh<CR> 
