function! misc#IsWindows()
  return has('win16') || has('win32') || has('win64')
endfunction


function! misc#IsCygwin()
  return has('win32unix')
endfunction


function! misc#IsMac()
  return has('mac') || has('macunix') || has('gui_macvim')
endfunction


function! misc#IsLinux()
  return !misc#IsMac() && has('unix')
endfunction


function! misc#IsStarting()
  return has('vim-starting')
endfunction


function! misc#IsGui()
  return has('gui-running')
endfunction


function! misc#IsTmuxRunning()
  return !empty($TMUX)
endfunction


function! misc#TmuxProc()
  return system('tmux display-message -p "#W"')
endfunction


function! misc#Mkdir(dir)
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


function! misc#PickExecutable(pathspecs)
  for l:pathspec in filter(a:pathspecs, '!empty(v:val)')
    for l:path in reverse(glob(l:pathspec, 0, 1))
      if executable(l:path)
        return l:path
      endif
    endfor
  endfor
endfunction
