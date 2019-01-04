function! misc#isWindows()
  return has('win16') || has('win32') || has('win64')
endfunction


function! misc#isCygwin()
  return has('win32unix')
endfunction


function! misc#isMac()
  return has('mac') || has('macunix') || has('gui_macvim')
endfunction


function! misc#isLinux()
  return !misc#isMac() && has('unix')
endfunction


function! misc#isStarting()
  return has('vim-starting')
endfunction


function! misc#isGui()
  return has('gui-running')
endfunction


function! misc#isTmuxRunning()
  return !empty($TMUX)
endfunction


function! misc#tmuxProc()
  return system('tmux display-message -p "#W"')
endfunction


function! misc#mkdir(dir)
  if !exists('*mkdir')
    return g:false
  endif

  let l:dir = expand(a:dir)
  if isdirectory(l:dir)
    return g:true
  endif

  if !exists(dir)
    return mkdir(dir, 'p')
  else
    return g:true
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
