" Utilities
function! misc#on_filetype() abort
  if execute('filetype') =~# 'OFF'
    " lazy loading
    silent! filetype plugin indent on
    syntax enable
    filetype detect
  endif
endfunction
