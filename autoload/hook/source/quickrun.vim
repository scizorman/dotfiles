function hook#source#quickrun#rc()
  " let g:quickrun_config = get(g: 'quickrun_config', {})
  let g:quickrun_config = {}
  let g:quickrun_config._ = {
        \ 'runner': 'vimproc',
        \ 'runner/vimproc/updatetime': 50,
        \ 'outputter': 'quickfix',
        \ 'outputter/error/success': 'buffer',
        \ 'outputter/error/error': 'quickfix',
        \ 'outputter/buffer/split': ':botright 8sp',
        \ }
endfunction
