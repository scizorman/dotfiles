function! misc#is_windows()
  return has('win16') || has('win32') || has('win64')
endfunction

function! misc#is_cygwin()
  return has('win32unix')
endfunction

function! misc#is_mac()
  return has('mac') || has('macunix') || has('gui_macvim')
endfunction

function! misc#is_linux()
  return !misc#is_mac() && has('unix')
endfunction


function! misc#is_starting()
  return has('vim_starting')
endfunction

function! misc#is_gui()
  return has('gui_running')
endfunction

function! misc#is_tmux_running()
  return !empty($TMUX)
endfunction

function! misc#tmux_proc()
  return system('tmux display-message -p "#W"')
endfunction


function! misc#on_filetype() abort
  if execute('filetype') =~# 'OFF'
    " lazy loding
    silent! filetype plugin indent on
    syntax enable
    filetype detect
  endif
endfunction


function! misc#toggle_option(option_name) abort
  execute 'setlocal' a:option_name . '!'
  execute 'setlocal' a:option_name . '?'
endfunction

function! misc#mkdir(dir)
  if !exists('*mkdir')
    return v:false
  endif

  let l:dir = expand(a:dir)
  if isdirectory(l:dir)
    return v:true
  endif

  if !exists(dir)
    return mkdir(dir, 'p')
  else
    return v:true
  endif
endfunction


function! misc#pickExecutable(pathspecs)
  for l:pathspec in filter(a:pathspecs, '!empty(v:val)')
    for l:path in reverse(glob(l:pathspec, 0, 1))
      if executable(l:path)
        return l:path
      endif
    endfor
  endfor
endfunction
