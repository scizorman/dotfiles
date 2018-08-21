function plugs#lightline#hook_add()
  let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [['mode', 'paste'], ['fugitive', 'readonly', 'filepath', 'modified']],
  \   'right': [
  \     ['lineinfo'], ['percent'],
  \     ['ale_ok', 'ale_warning', 'ale_error', 
  \      'char_code', 'fileformat', 'fileencoding', 'filetype']
  \   ],
  \ },
  \ 'component_function': {'filepath': 'LightlineFilepath'},
  \ 'component_expand': {
  \   'ale_ok': 'LightlineAleOk',
  \   'ale_warning': 'LightlineAleWarning',
  \   'ale_error': 'LightlineAleError',
  \ },
  \ 'component_type': {'ale_ok': 'ok', 'ale_warning': 'warning', 'ale_error': 'error'},
  \ }
endfunction


function! LightlineFilepath()
  if winwidth(0) > 120
    return expand('%:s')
  else
    return expand('%:t')
  endif
endfunction


function! LightlineAleError() abort
  return s:ale_string(0)
endfunction


function! LightlineAleWarning() abort
  return s:ale_string(1)
endfunction


function! LightlineAleOk() abort
  return s:ale_string(2)
endfunction


function! s:ale_string(mode)
  if !exists('g:ale_buffer_info')
    return ''
  endif

  let l:buffer = bufnr('%')
  let l:counts = ale#statusline#Count(l:buffer)
  let [l:error_format, l:warning_format, l:no_errors] = g:ale_statusline_format

  if a:mode == 0
    let l:errors = l:counts.error + l:counts.style_error
    return l:errors ? printf(l:error_format, l:errors) : ''
  elseif a:mode == 1
    let l:warnings = l:counts.warning + l:counts.style_warning
    return l:warnings ? printf(l:warning_format, l:warnings) : ''
  endif

  return l:counts.total ? '' : l:no_errors
endfunction


augroup LightLineOnALE
  autocmd!
  autocmd User ALELint call lightline#update()
augroup END
