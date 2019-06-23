" -----------------------------------------------------------------------------
" Encoding
" -----------------------------------------------------------------------------
" The automatic recognition of the character code

" When does not include Japanese, use encoding for fileencoding.
function! s:recheck_fenc() abort
  let l:is_multi_byte = search("[^\x01-\x7e]", 'n', 100, 100)
  if &fileencoding =~# 'iso-2022-jp' && !l:is_multi_byte
    let &fileencoding = &encoding
  endif
endfunction

autocmd GlobalAutoCmd BufReadPost * call s:recheck_fenc()

set fileformat=unix          " default fileformat
set fileformats=unix,dos,mac " automatic recognition of a new line code


" Command group opening with a specific character code again.
" In paticular effective when I am garbled in a terminal.
command! -bang -bar -complete=file -nargs=? Utf8      " open in UTF-8 again
      \ edit<bang> ++encoding=utf-8 <args>
command! -bang -bar -complete=file -nargs=? Iso2022Jp " open in ISO-2022-JP again
      \ edit<bang> ++encoding=iso-2022-jp <args>
command! -bang -bar -complete=file -nargs=? Cp932     " open in Shift_JIS again
      \ edit<bang> ++encoding=cp932 <args>
command! -bang -bar -complete=file -nargs=? EucJp     " open in EUC-JP again
      \ edit<bang> ++encoding=euc-jp <args>
command! -bang -bar -complete=file -nargs=? Utf16     " open in UTF-16 again
      \ edit<bang> ++encoding=ucs-2le <args>
command! -bang -bar -complete=file -nargs=? Latin1    " open in Latin1 again
      \ edit<bang> ++encoding=latin1 <args>

" Tried to make a file note version.
command! WUtf8 setlocal fileencoding=utf-8
command! WCp932 setlocal fileencoding=cp932
command! WLatin1 setlocal fileencoding=latin1

" Appoint a line feed.
command! -bang -complete=file -nargs=? WUnix
      \ write<bang> ++fileformat=unix <args> | edit <args>
command! -bang -complete=file -nargs=? WDos
      \ write<bang> ++fileformat=dos <args> | edit <args>
