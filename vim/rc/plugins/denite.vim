if executable('rg')
  call denite#custom#var('file/rec', 'command',
        \ ['rg', '--files', '--hidden', '--glob', '!.git'])
  call denite#custom#var('grep', 'command',
        \ ['rg', '--threads', '1'])
  call denite#custom#var('grep', 'default_opts',
        \ ['-i', '--vimgrep', '--no-heading'])
  call denite#custom#var('grep', 'recursive_opts',
        \ [])
endif

call denite#custom#source('buffer', 'matchers',
      \ ['matcher/fuzzy', "matcher/project_files"])
call denite#custom#source('file/old', 'matchers',
      \ ['matcher/fuzzy', "matcher/project_files"])
call denite#custom#source('tag', 'matchers',
      \ ['matcher/substring'])

call denite#custom#source('file/old', 'converters',
      \ ['git', 'ls-files', '-co', '--exclude-standards'])

call denite#custom#option('default', {
      \ 'prompt': '> ',
      \ 'source_names': 'short',
      \ 'split': 'floating',
      \ 'statusline': v:false,
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
      \ ['dein/dein.toml', expand($XDG_CONFIG_HOME . '/nvim/rc/dein.toml')],
      \ ['dein/dein_lazy.toml', expand($XDG_CONFIG_HOME . '/nvim/rc/dein_lazy.toml')],
      \ ]
let s:menus.zsh = {
      \ 'description': 'Edit your Zsh configuration',
      \ }
let s:menus.zsh.file_candidates = [
      \ ['zshrc', expand($ZDOTDIR . '/.zshrc')],
      \ ['zprofile', expand($ZDOTDIR . '/.zprofile')],
      \ ['zshenv', expand($ZDOTDIR . '/.zshenv')],
      \ ]
call denite#custom#var('menu', 'menus', s:menus)
