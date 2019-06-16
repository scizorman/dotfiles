let g:dein#install_progress_type = 'title'
" let g:dein#install_log_filename = ''

let s:dein_path = {
      \ 'cache': expand($XDG_CACHE_HOME . '/dein'),
      \ 'repos': expand($XDG_CACHE_HOME . '/dein/repos/github.com/Shougo/dein.vim'),
      \ 'vimproc': expand($XDG_CACHE_HOME . '/dein/repos/github.com/Shougo/vimproc.vim'),
      \ 'toml': expand($XDG_CONFIG_HOME . '/nvim/dein/dein.toml'),
      \ 'lazy_toml': expand($XDG_CONFIG_HOME) . '/nvim/dein/dein_lazy.toml',
      \ }

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_path.repos)
    execute '!git clone https://github.com/Shougo/dein.vim ' . s:dein_path.dein
    execute '!git clone https://github.com/Shougo/vimproc.vim ' . s:dein_path.vimproc
    execute '!cd ' . s:dein_path.vimproc ' && make'
  endif

  execute 'set runtimepath^=' . fnamemodify(s:dein_path.repos, ':p')
endif

if !dein#load_state(s:dein_path.cache)
  finish
endif

call dein#begin(s:dein_path.cache)

call dein#load_toml(s:dein_path.toml, {'lazy': 0})
call dein#load_toml(s:dein_path.lazy_toml, {'lazy': 1})

call dein#end()
call dein#save_state()

if !misc#is_starting() && dein#check_install()
  call dein#install()
endif
