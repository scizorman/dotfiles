" Save last cursor position.
augroup LastPosition
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g '\"" | endif
augroup END

" Show quicfix after grepcmd.
augroup GrepCmd
  autocmd!
  autocmd QuickFixCmdPost vim,grep,make if len(getqflist()) != 0 | cwindow | endif
augroup END

" IME control for fcitx
if has('unix') && executable('fcitx-remote')
  let g:input_toggle = 0

  function! Fcitx2en()
    let s:input_status = system("fcitx-remote")
    if s:input_status == 2
      let g:input_toggle = 1
      let l:a = system("fcitx-remote -c")
    endif
  endfunction

  function! Fcitx2zh()
    let s:input_status = system("fcitx-remote")
    if s:input_status != 2 && g:input_toggle == 1
      let l:a = system("fcitx-remote -o")
      let g:input_toggle = 0
    endif
  endfunction

  augroup FixtxIMEControl
    autocmd!
    " Leave Insert mode.
    autocmd InsertLeave * call Fcitx2en()
    " Enter Insert mode.
    autocmd InsertEnter * call Fcitx2zh()
  augroup END
endif

" Reload change file.
augroup vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END
