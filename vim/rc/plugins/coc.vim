" use <TAB> for trigger completion with characters ahead and navigation
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <silent><expr> <S-TAB>
      \ pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Key mappings
" Navigate diagnostics
nmap <silent>[g <Plug>(coc-diagnostic-prev)
nmap <silent>]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gy <Plug>(coc-type-definition)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>gr <Plug>(coc-references)

nmap <silent>F <Plug>(coc-format)

" Show documentation in preview window
nnoremap <silent>K :call <SID>show_documentation()<CR>

function! s:show_documentation() abort
  if (index(['vim', 'help'], &filetype) >= 0)
    execute 'help ' . expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renamings
nmap <Leader>rn <Plug>(coc-rename)

" Applying codeAction to the selected region
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer
nmap <leader>ac <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line
nmap <leader>qf <Plug>(coc-fix-current)

" Add native statusline support
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CocList
" Show all diagnostics
nnoremap <silent><nowait> <localleader>a :<C-u>CocList diagnostics<CR>
" Manage extensions
nnoremap <silent><nowait> <localleader>e :<C-u>CocList extensions<CR>
" Show commands
nnoremap <silent><nowait> <localleader>c :<C-u>CocList commands<CR>
" Find symbol of current document
nnoremap <silent><nowait> <localleader>o :<C-u>CocList outline<CR>
" Search worklocalleader symbols
nnoremap <silent><nowait> <localleader>s :<C-u>CocList -I symbols<CR>
" Do default action for next item
nnoremap <silent><nowait> <localleader>j :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <localleader>k :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <localleader>p :<C-u>CocListResume<CR>
