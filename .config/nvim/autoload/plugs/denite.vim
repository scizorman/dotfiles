function plugs#denite#hook_source()
  " Keymappings
  call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
  call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
  call denite#custom#map('insert', '<C-s>', '<denite:do_action:split>', 'noremap')
  call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>', 'noremap')
  call denite#custom#map('insert', '<C-t>', '<denite:do_action:tabopen>', 'noremap')

  call denite#custom#source(
    \ 'file_rec',
    \ 'matchers',
    \ ['matcher_fuzzy', 'matcher_project_files', 'matcher_ignore_globs'],
    \ )

  call denite#custom#filter(
    \ 'matcher_ignore_globs',
    \ 'ignore_globs',
    \ ['.git/', '.ropeproject/', '.__pycache__/', 'venv/', 'images/', '*.min.*',
    \  'img/', 'fonts/', 'vendor/', 'node_modules/', '*pyc', '.DS_Store']
    \ )

  call denite#custom#source(
    \ 'fire_mru',
    \ 'matchers',
    \ ['matcher/fuzzy', 'matcher/project_files'],
    \ )

  if executable('pt') || executable('ag')
    let l:grep_source = executable('pt') ? 'pt' : 'ag'

    call denite#custom#var(
      \ 'file_rec',
      \ 'command',
      \ [s:grep_source, '--follow', '--nocolor', '--nogroup', '--hidden', '-g', ''],
      \ )
    call denite#custom#var(
      \ 'grep',
      \ 'command',
      \ [s:grep_source, '--nogroup', '--nocolor', '--smart-case', '-hidden'],
      \ )
    call denite#custom#var('grep', 'default_opts', [])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'separator', ['--'])
  endif
endfunction
