if &compatible
  set nocompatible
endif

let s:dein_dir = expand('$CACHE/dein')

if dein#load_state(s:dein_dir)
  let s:toml_dir = expand('$XDG_CONFIG_HOME/nvim/toml')
  let s:toml_dein = s:toml_dir . '/dein.toml'
  let s:toml_lazy = s:toml_dir . '/dein_lazy.toml'
  let s:toml_neo = s:toml_dir . '/dein_neo.toml'
  let s:toml_python = s:toml_dir . '/dein_python.toml'

  call dein#begin(s:dein_dir)

  call dein#load_toml(s:toml_dein, {'lazy': 0})
  call dein#load_toml(s:toml_lazy, {'lazy': 1})
  call dein#load_toml(s:toml_neo, {'lazy': 1})
  call dein#load_toml(s:toml_python, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif
