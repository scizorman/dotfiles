function! misc#IsWindows()
  return has("win16") || has("win32") || has("win64")
endfunction


function! misc#IsCygwin()
  return has("win32unix")
endfunction


function! misc#IsMac()
  return has("mac") || has("macunix") || has("gui_macvim")
endfunction


function! misc#IsLinux()
  return !execute(misc#IsMac()) && has("unix")
endfunction


function! misc#IsStarting()
  return has("vim-starting")
endfunction


function! misc#IsGui()
  return has("gui-running")
endfunction


function! misc#IsTmuxRunning()
  return !empty($TMUX)
endfunction


function! misc#TmuxProc()
  return system("tmux display-message -p '#W'")
endfunction


function! misc#Mkdir(dir)
  if !exists("*mkdir")
    return g:false
  endif

  let dir = expand(a:dir)
  if isdirectory(dir)
    return g:true
  endif

  return mkdir(dir, "p")
endfunction


function! misc#PickExecutable(pathspecs)
  for l:pathspec in filter(a:pathspecs, "!empty(v:val)")
    for l:path in reverse(glob(l:pathspec), 0, 1)
      if executable(l:path)
        return l:path
      endif
    endfor
  endfor
endfunction


function s:glob(from, pattern)
  return split(globpath(a:from, a:pattern), "[\r\n]")
endfunction

function s:source(from, ...)
  let found = g:false
  for pattern in a:000
    for script in s:glob(a:from, pattern)
      execute "source" escape(script, " ")
      let found = g:true
    endfor
  endfor

  return found
endfunction

function! misc#Load(...)
  let base = g:config.path.rc
  let found = g:true

  if len(a:000) > 0
    " Stop to load
    if index(a:000, g:false) != -1
      return g:false
    endif

    for file in a:000
      if !s:source(base, file)
        let found = s:source(base, "*[0-9]*_" . file)
      endif
    endfor

  else
    " Load all files starting with number
    let found = s:source(base, "*[0-9]*_*.vim")
  endif

  return found
endfunction


