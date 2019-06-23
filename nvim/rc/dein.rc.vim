let g:dein#install_progress_type = 'title'
let g:dein#enable_notification = 1

let s:path = expand($XDG_CACHE_HOME . '/dein')
if !dein#load_state(s:path)
  finish
endif

let s:toml = expand($XDG_CONFIG_HOME . '/nvim//dein/dein.toml')
let s:lazy_toml = expand($XDG_CONFIG_HOME . '/nvim/dein/dein_lazy.toml')

call dein#begin(s:path, [
      \ expand('<sfile>'), s:toml, s:lazy_toml
      \ ])

call dein#load_toml(s:toml, {'lazy': 0})
call dein#load_toml(s:lazy_toml, {'lazy': 1})

call dein#end()
call dein#save_state()

if !misc#is_starting() && dein#check_install()
  call dein#install()
endif
