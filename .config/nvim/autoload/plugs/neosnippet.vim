function! plugs#neosnippet#hook_source()
  let g:neosnippet#data_directory = $XDG_CACHE_HOME . '/nvim/neosnippet'
  let g:neosnippet#enable_complete_done = 1
  let g:neosnippet#enable_completed_snippet = 1
  let g:neosnippet#expand_word_boundary = 0
  let g:neosnippet#disable_runtime_snippets = {
  \ 'c': 1,
  \ 'cpp': 1,
  \ 'go': 1,
  \ }
  let g:neosnippet#snippets_directory = g:nvim_path.nvim . '/neosnippet'
endfunction
