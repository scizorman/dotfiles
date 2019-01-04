function! hook#source#neosnippet#config()
  let g:neosnippet#data_directory = $XDG_CACHE_HOME . '/neosnippet'
  let g:neosnippet#snippets_directory = g:nvim_path.nvim . '/snippets'
  let g:neosnippet#enable_completed_snippet = 1
  Gautocmd CompleteDone * call neosnippet#complete_done()

  if has('conceal')
    set conceallevel=2 concealcursor=niv
  endif
endfunction
