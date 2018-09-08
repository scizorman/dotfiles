function plugs#denite#hook_source()
  call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
  call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')
  call denite#custom#map('insert', '<C-s>', '<denite:do_action:split>', 'noremap')
  call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>', 'noremap')
  call denite#custom#map('insert', '<C-t>', '<denite:do_action:tabopen>', 'noremap')

  call denite#custom#source(
        \ 'buffer',
        \ 'matchers',
        \ ['matcher/fuzzy', 'matcher/project_files'],
        \ )

  call denite#custom#var('grep', 'command', ['pt'])
  call denite#custom#var(
        \ 'grep',
        \ 'default-opts',
        \ ['--follow', '--hidden', '--nocolor',  '--nogroup', '--ignore="_*"']
        \ )
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', ['-e'])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opts', [])

  call denite#custom#source(
        \ 'file_rec',
        \ 'matchers',
        \ ['matcher/fuzzy', 'matcher/project_files', 'matcher/ignore_globs'],
        \ )
  call denite#custom#source('file_rec', 'sorters', ['sorter/sublime'])
  call denite#custom#var(
        \ 'file_rec',
        \ 'command',
        \ ['pt', '--nocolor', '--nogroup', '--follow', '--hidden', '-g=', '']
        \ )

  call denite#custom#source(
        \ 'file_mru',
        \ 'matchers',
        \ ['matcher/fuzzy', 'matcher/project_files'],
        \ )

  call denite#custom#source(
        \ 'line',
        \ 'command',
        \ ['pt', '--nocolor', '--nogroup', '--follow', '--hidden', '-g=', '']
        \ )

  call denite#custom#filter(
        \ 'matcher/ignore_globs',
        \ 'ignore_globs',
        \ ['.git/', '.ropeproject/', '.__pycache__/', 'venv/', 'images/', '*.min.*',
        \  'img/', 'fonts/', 'vendor/', '*pyc', '.DS_Store'],
        \ )

  let s:menus = {}
  let s:menus.zsh = {
        \ 'description': 'Edit your import zsh configuration'
        \ }
  let s:menus.zsh.file_candidates = [
        \ ['zshrc', '~/.zshrc'],
        \ ['zshenv', '~/.zshenv'],
        \ ]
  call denite#custom#var('menu', 'menus', s:menus)
endfunction
