let g:dein#auto_recache = 1
let g:dein#install_progress_type = 'title'
let g:dein#enable_notification = 1

let s:path = expand('$XDG_CACHE_HOME/dein')
if !dein#load_state(s:path)
  finish
endif

let s:toml = expand($XDG_CONFIG_HOME) . '/nvim/rc/dein.toml'
let s:lazy_toml = expand($XDG_CONFIG_HOME) . '/nvim/rc/dein_lazy.toml'
let s:ddc_toml = expand($XDG_CONFIG_HOME) . '/nvim/rc/ddc.toml'
let s:ft_toml = expand($XDG_CONFIG_HOME) . '/nvim/rc/dein_ft.toml'

call dein#begin(s:path, [
     \ expand('<sfile>'), s:toml, s:lazy_toml, s:ft_toml
     \ ])

call dein#load_toml(s:toml, {'lazy': 0})
call dein#load_toml(s:lazy_toml, {'lazy': 1})
call dein#load_toml(s:ddc_toml, {'lazy': 1})
call dein#load_toml(s:ft_toml)

call dein#end()
call dein#save_state()

" filetype plugin indent on
syntax enable

if !has('vim_starting') && dein#check_install()
  call dein#install()
endif
