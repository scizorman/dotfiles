if &compatible
  set nocompatible
endif

let s:dein_dir = expand('$CACHE/dein')

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:toml_list = expand('$HOME/.vim/toml/**.toml')
  let s:index = 0

  for s:toml_file in split(s:toml_list, '\n')
    if s:index == 0
      let s:toml_lazy = 0
      let s:index = s:index + 1
    else
      let s:toml_lazy = 1
    endif

    call dein#load_toml(s:toml_file, {'lazy': s:toml_lazy})
  endfor

  call dein#end()
  call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
  call dein#install()
endif
