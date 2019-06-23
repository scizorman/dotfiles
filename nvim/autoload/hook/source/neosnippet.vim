function! hook#source#neosnippet#config()
  let g:neosnippet#data_directory = $XDG_CACHE_HOME . '/neosnippet'
  let g:neosnippet#snippets_directory = $XDG_CONFIG_HOME . '/nvim/snippets'
  let g:neosnippet#enable_completed_snippet = 1
  autocmd GlobalAutoCmd CompleteDone * call neosnippet#complete_done()
endfunction
