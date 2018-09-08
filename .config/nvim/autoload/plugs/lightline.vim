function plugs#lightline#hook_add()
  let g:lightline = {
        \ 'colorscheme': 'tender',
        \ 'active': {
        \   'left': [['mode', 'paste'], ['readonly', 'filename', 'modified']],
        \   'right': [['lineinfo'], ['percent'],
        \             ['ale', 'fileformat', 'fileencoding', 'filetype']],
        \ },
        \ 'component_function': {
        \   'ale': 'LightlineAle',
        \   'fileformat': 'LightlineFileformat',
        \   'filetype': 'LightlineFiletype',
        \   'modified': 'LightlineModified',
        \   'readonly': 'LightlineReadonly',
        \ }
        \ }
endfunction


function! LightlineAle()
  let l:count = ale#statusline#Count(bufnr(''))
  let l:errors = l:count.error + l:count.style_error
  let l:warnings = l:count.warning + l:count.style_warning
  return l:count.total == 0 ? "\uf058 " : "\uf057  " . l:errors . ' ' . "\uf06a  " . l:warnings
endfunction


function! LightlineFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' '. WebDevIconsGetFileFormatSymbol()) . ' ' : ''
endfunction


function! LightlineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() . ' ' : 'no ft') : ''
endfunction


function! LightlineModified()
  return &filetype == 'help\|vimfiler\|gundo' ? '' : &modified ? "+" : &modifiable ? '' : '-'
endfunction


function! LightlineReadonly()
  return &filetype !~? 'help\|vimfiler\|gundo' && &readonly ? "\uf023" : ''
endfunction


augroup LightLineOnALE
  autocmd!
  autocmd User ALELint call lightline#update()
augroup END
