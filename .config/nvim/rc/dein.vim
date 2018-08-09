let s:dein_dir = empty($XDG_CACHE_HOME)
    \ ? expand('~/.cache/dein')
    \ : expand($XDG_CACHE_HOME.'/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~ '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
    endif

    execute 'set runtimepath^=' . s:dein_repo_dir
endif

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    let s:toml_dir = g:config.path.vim . '/toml'
    call dein#load_toml(s:toml_dir.'/dein.toml', {'lazy', 0})
    call dein#load_toml(s:toml_dir.'/dein_lazy.toml', {'lazy', 1})

    call dein#end()
    call dein#save_state()
endif

if !g:config.vim_starting && dein#check_install()
    call dein#install()
endif
