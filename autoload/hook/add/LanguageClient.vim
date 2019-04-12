function hook#add#LanguageClient#config()
  set hidden

  let g:LanguageClient_serverCommands = {
        \ 'go': ['gopls'],
        \ 'python': ['pyls'],
        \ 'vue': ['vls'],
        \ }
  let g:LanguageClient_autoStart = 1
  let g:LanguageClient_autoStop = 1

  augroup LanguageClient_config
    autocmd!
    autocmd User LanguageClientStarted setlocal signcolumn=yes
    autocmd User LanguageClientStopped setlocal signcolumn=auto
  augroup END

endfunction
