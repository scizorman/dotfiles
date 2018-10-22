function hook#add#lsp#rc()
  let g:lsp_auto_enable = 1

  " C Family
  if executable('clangd')
    Gautocmd User lsp_setup call lsp#register_server({
          \ 'name': 'clangd',
          \ 'cmd': {server_info->['clangd']},
          \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
          \ })
  endif

  " Golang
  if executable('go-langserver')
    Gautocmd User lsp_setup call lsp#register_server({
          \ 'name': 'go-langserver',
          \ 'cmd': {server_info->['go-langserver', '-gocodecompletion']},
          \ 'whitelist': ['go'],
          \ })
  endif

  " Python
  if executable('pyls')
    Gautocmd User lsp_setup call lsp#register_server({
          \ 'name': 'pyls',
          \ 'cmd': {server_info->['pyls']},
          \ 'whitelist': ['python'],
          \ })

    " Gautocmdft python setlocal omnifunc=lsp#complete
  endif
endfunction
