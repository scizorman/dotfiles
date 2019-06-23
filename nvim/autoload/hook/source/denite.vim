function hook#source#denite#config()
  if executable('rg')
    call denite#custom#var('file/rec', 'command',
          \ ['rg', '--files', '--glob', '!.git'])
    call denite#custom#var('grep', 'command',
          \ ['rg', '--threads', '1'])
    call denite#custom#var('grep', 'default_opts',
          \ ['-i', '--vimgrep', '--no-heading'])
    call denite#custom#var('grep', 'recursive_opts',
          \ [])
  endif

  call denite#custom#source('buffer', 'matchers',
        \ ['matcher/fuzzy', 'matcher/project_files'])
  call denite#custom#source('file/old', 'matchers',
        \ ['matcher/fuzzy', 'matcher/project_files'])
  " call denite#custom#source('file/rec', 'matchers',
  "      \ ['matcher/fuzzy', 'matcher/project_files', 'matcher/ignore_globs'])
  call denite#custom#source('tag', 'matchers',
        \ ['matcher/substring'])

  call denite#custom#source('file/old', 'converters',
        \ ['converter/relative_word'])

  call denite#custom#alias('source', 'file/rec/git', 'file/rec')
  call denite#custom#var('file/rec/git', 'command',
        \ ['git', 'ls-files', '-co', '--exclude-standard'])

  let l:denite_winwidth_percent = 0.5
  let l:denite_winheight_percent = 0.3
  call denite#custom#option('default', {
        \ 'prompt': '> ',
        \ 'source_names': 'short',
        \ 'split': 'floating',
        \ 'statusline': v:false,
        \ 'winwidth': float2nr(&columns * l:denite_winwidth_percent),
        \ 'wincol': float2nr((&columns - (&columns * l:denite_winwidth_percent)) / 2),
        \ 'winheight': float2nr(&lines * l:denite_winheight_percent),
        \ 'winrow': float2nr((&lines - (&lines * l:denite_winheight_percent)) / 2),
        \ })

  call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
        \ ['.git', '__pycache__', '.ropeproject/', 'venv',
        \  'node_modules/', 'images/', 'img/', '*.min.*', 'fonts/'])


  let s:menus = {}
  let s:menus.nvim = {
        \ 'description': 'Edit your Neovim configurations',
        \ }
  let s:menus.nvim.file_candidates = [
        \ ['init.vim', expand($XDG_CONFIG_HOME . '/nvim/init.vim')],
        \ ['dein/dein.toml', expand($XDG_CONFIG_HOME . '/nvim/dein/dein.toml')],
        \ ['dein/dein_lazy.toml', expand($XDG_CONFIG_HOME . '/nvim/dein/dein_lazy.toml')],
        \ ]
  let s:menus.zsh = {
        \ 'description': 'Edit your Zsh configuration'
        \ }
  let s:menus.zsh.file_candidates = [
        \ ['zshrc', expand($ZDOTDIR . '/.zshrc')],
        \ ['zprofile', expand($ZDOTDIR . '/.zprofile')],
        \ ['zshenv', expand($ZDOTDIR . '/.zshenv')],
        \ ]
  call denite#custom#var('menu', 'menus', s:menus)
endfunction
