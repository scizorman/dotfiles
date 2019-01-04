function! hook#add#gina#config()
  call gina#custom#command#option('diff', '--opener', 'vsplit')
  call gina#custom#execute(
      \ '/\%(commit\)',
      \ 'setlocal colorcolumn=79 expandtab shiftwidth=2 softtabstop=2 tabstop=2 winheight=40',
      \ )
  call gina#custom#execute(
      \ '/\%(status\|branch\|ls\|grep\|changes\|tag\)',
      \ 'setlocal winfixheight',
      \ )

  " Mapping
  call gina#custom#mapping#nmap(
        \ '/\%(commit\|status\|branch\|ls\|grep\|changes\|tag\)',
        \ 'q', ':<C-u> q<CR>', {'noremap': 1, 'silent': 1},
        \ )
endfunction
