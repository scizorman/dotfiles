"
" Environmental Variables
"
let $XDG_CACHE_HOME = expand('~/.cache')
let $XDG_CONFIG_HOME = expand('~/.config')
let $XDG_DATA_HOME = expand('~/.local/share')


"
" GlobalAutoCmd
"
augroup GlobalAutoCmd
  autocmd!
augroup END
command! -nargs=* Gautocmd autocmd GlobalAutoCmd <args>
command! -nargs=* Gautocmdft autocmd GlobalAutoCmd FileType <args>


" Use plain vim when vim was invoked by 'sudo' command or invoked as 'git difftool'
if exists('$SUDO_USER') || exists('$GIT_DIR')
  finish
endif

" Set True = 1, False = 0
let g:true = 1
let g:false = 0


"
" Functions
"
function! s:config()
  let config = {}

  let config.is_windows = has('win16') || has('win32') || has('win64')
  let config.is_cygwin = has('win32unix')
  let config.is_mac = !config.is_windows && !config.is_cygwin && (
    \ has('mac') || has('macunix') || has('gui_macvim') || (
      \ !executable('xdg-open') && system('uname') =~? '^darwin'
    \ )
  \ )
  let config.is_linux = !config.is_mac && has('unix')

  let config.is_starting = has('vim-starting')
  let config.is_gui = has('gui_running')
  " let config.hostname = hostname()

  " Neovim
  let conf_path = expand($XDG_CONFIG_HOME . '/nvim')
  let data_path = expand($XDG_DATA_HOME . '/nvim')

  let config.path = {
    \ 'vim': conf_path,
    \ 'rc': conf_path . '/rc',
    \ 'backup': data_path . '/backup',
    \ 'swap': data_path . '/swap',
    \ 'undo': data_path . '/undo',
  }

  let config.bin = {
    \ 'pt': executable('pt'),
    \ 'ag': executable('ag'),
    \ 'osascript': executable('osascript'),
    \ 'open': executable('open'),
    \ 'chmod': executable('chmod'),
    \ 'qlmanage': executable('qlmanage'),
  }

  " Tmux
  let config.is_tmux_running = !empty($TMUX)
  let config.is_tmux_proc = system('tmux display-message -p "#W"')

  let config.vimrc = {
    \ 'plugin_on': g:true,
    \ 'suggest_vimplug_init': g:true,
    \ 'goback_to_eof2bof': g:false,
    \ 'save_window_position': g:true,
    \ 'restore_cursor_position': g:true,
    \ 'statusline_manually': g:true,
    \ 'add_execute_perm': g:false,
    \ 'colorize_statusline_insert': g:true,
    \ 'manage_rtp_manually': g:true,
    \ 'auto_cd_file_parentdir': g:true,
    \ 'ignore_all_settings': g:true,
    \ 'check_plug_update': g:true,
  }

  return config
endfunction

function! s:glob(from, pattern)
  return split(globpath(a:from, a:pattern), "[\r\n]")
endfunction

function! s:source(from, ...)
  let found = g:false
  for pattern in a:000
    for script in s:glob(a:from, pattern)
      execute 'source' escape(script, ' ')
      let found = g:true
    endfor
  endfor

  return found
endfunction

function! s:load(...) abort
  let base = g:config.path.rc
  let found = g:true

  if len(a:000) > 0
    " Stop to load
    if index(a:000, g:false) != -1
      return g:false
    endif
    for file in a:000
      if !s:source(base, file)
        let found = s:source(base, '*[0-9]*_' . file)
      endif
    endfor
  else
    " Load all files starting with number
    let found = s:source(base, '*[0-9]*_*.vim')
  endif

  return found
endfunction

function! s:pick_executable(pathspecs) abort
  for s:pathspec in filter(a:pathspecs, '!empty(v:val)')
    for s:path in reverse(glob(s:pathspec, 0, 1))
      if executable(s:path)
        return s:path
      endif
    endfor
  endfor
endfunction


"
" Load Python
"
let g:python_host_prog = s:pick_executable(
  \ ['/usr/local/bin/python2', '/usr/bin/python2', '/bin/python2']
\ )
let g:python3_host_prog = s:pick_executable(
  \ ['/usr/local/bin/python3', '/usr/bin/python3', '/bin/python3']
\ )
endif


"
" Initialize
"
let g:config = s:config()

let g:config.vimrc.plugin_on = g:true
let g:config.vimrc.manage_rtp_manually = g:false
let g:config.vimrc.plugin_on =
  \ g:config.vimrc.manage_rtp_manually == g:true
  \ ? g:false
  \ : g:config.vimrc.plugin_on

if g:config.is_starting
  scriptencoding utf-8
  set runtimepath&

  " Check if there are plugins not to be installed
  augroup VimrcCheckPlug
    autocmd!
    if g:config.vimrc.check_plug_update == g:true
      autocmd VimEnter * if !argc() | call g:plug.check_installation | endif
    endif
  augroup END

  if has('reltime')
    let g:startuptime = reltime()
    augroup VimrcStartUpTime
      autocmd!
      autocmd VimEnter * g:startuptime = reltime(g:startuptime) | redraw
        \ | echomsg 'startuptime: ' . reltimestr(g:startuptime)
    augroup END
  endif
endif

execute 'set runtimepath^=' . fnameescape(g:config.path.rc)

call s:load('plug.vim')

call s:load('options.vim')
call s:load('command.vim')
call s:load('mapping.vim')

call s:load('misc.vim')
call s:load('app.vim')

" Must be written at the last
" See :help secure
set secure
