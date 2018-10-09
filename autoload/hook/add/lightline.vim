function hook#add#lightline#rc()
  let g:lightline = {
        \ 'colorscheme': 'tender',
        \ 'active': {
        \   'left': [['mode', 'paste'], ['gitbranch', 'readonly', 'filename', 'modified']],
        \   'right': [['lineinfo'], ['percent'],
        \             ['ale', 'fileformat', 'fileencoding', 'filetype']],
        \ },
        \ 'component_function': {
        \   'ale': 'LightlineAle',
        \   'gitbranch': 'LightlineGitbranch',
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
    return "\uf126 " . l:gitbranch
  else
    return ''
  endif
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
