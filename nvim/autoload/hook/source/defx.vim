function hook#source#defx#config()
  call defx#custom#column('mark', {
        \ 'readonly_icon': '✗',
        \ 'selected_icon': '✓',
        \ })

  call defx#custom#column('icon', {
        \ 'directory_icon': '▸',
        \ 'opened_icon': '▾',
        \ 'root_icon': ' ',
        \ })

  let l:ignore_globs = [
        \ '.git',
        \ '__pycache__', 'ropeproject', 'venv',
        \ ]
  call defx#custom#option('_', {
        \ 'toggle': v:true,
        \ 'direction': 'topleft',
        \ 'split': 'vertical',
        \ 'winwidth': 30,
        \ })
endfunction
