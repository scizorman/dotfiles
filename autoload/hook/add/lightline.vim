function hook#add#lightline#config()
  let g:lightline = {
        \ 'colorscheme': 'dracula',
        \ 'active': {
        \   'left': [['mode', 'paste'], ['gitbranch', 'readonly', 'filepath', 'modified']],
        \   'right': [['lineinfo'], ['percent'],
        \             ['ale', 'fileformat', 'fileencoding', 'filetype']],
        \ },
        \ 'component_function': {
        \   'ale': 'LightlineAle',
        \   'gitbranch': 'LightlineGitbranch',
        \   'filepath': 'LightlineFilepath',
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


function! LightlineGitbranch()
  let l:gitbranch = gina#component#repo#branch()
  if &filetype !~? 'vimfiler\|gundo' && !empty(l:gitbranch)
    return winwidth(0) > 100 ? "\uf126 " . l:gitbranch : ''
  else
    return ''
  endif
endfunction

function! LightlineFilepath()
  let l:width = winwidth(0)
  if l:width > 150
    return expand('%:s')
  elseif l:width > 75
    return expand('%:t')
  else
    return ''
  endif
endfunction


function! LightlineFileformat()
  return winwidth(0) > 75 ? (&fileformat . ' '. WebDevIconsGetFileFormatSymbol()) . ' ' : ''
endfunction


function! LightlineFiletype()
  return winwidth(0) > 75 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() . ' ' : 'no ft') : ''
endfunction


function! LightlineModified()
  return &filetype ==? 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction


function! LightlineReadonly()
  return &filetype !~? 'help\|vimfiler\|gundo' && &readonly ? "\uf023" : ''
endfunction


augroup LightLineOnALE
  autocmd!
  autocmd User ALELint call lightline#update()
augroup END
