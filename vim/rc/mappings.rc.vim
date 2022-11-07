" Insert mode
" like Emacs
" next char
inoremap <C-f> <Right>
" previous char
inoremap <C-b> <Left>
" delete char
inoremap <C-d> <Del>

" Normal mode
" highlight and replace the word of the cursor position
nmap # *:%s/<C-r>///g<Left><Left>

" remove highlights
nnoremap <silent><C-l> :<C-u>nohlsearch<CR>

" do not yank
nnoremap x "_x

nnoremap <C-Up> "zdd<Up>"zP
nnoremap <C-Down> "zdd"zp

" Visual mode
vnoremap <C-Up> "zx<Up>"zP`[V`]
vnoremap <C-Down> "zx"zp`[V`]

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
