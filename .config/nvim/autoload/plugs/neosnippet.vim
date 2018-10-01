function! plugs#neosnippet#hook_source()
  let g:neosnippet#data_directory = $XDG_CACHE_HOME . '/neosnippet'
  let g:neosnippet#snippets_directory = g:nvim_path.nvim . '/snippets'
  let g:neosnippet#enable_complete_done = 1
  let g:neosnippet#enable_completed_snippet = 1

  if has('conceal')
    set conceallevel=2 concealcursor=niv
  endif
endfunction
