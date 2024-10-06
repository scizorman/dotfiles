" Default fileformat
set fileformat=unix
" Automatic recognition of a new line cord
set fileformats=unix,dos,mac

" Command group opening with a specific character code again
" In particular effective when I am garbled in a terminal
command! -bang -bar -complete=file -nargs=? Utf8
      \ edit<bang> ++enc=utf-8 <args>
command! -bang -bar -complete=file -nargs=? Iso2022jp
      \ edit<bang> ++enc=iso-2022-jp <args>
command! -bang -bar -complete=file -nargs=? Cp932
      \ edit<bang> ++enc=cp932 <args>
command! -bang -bar -complete=file -nargs=? Euc
      \ edit<bang> ++enc=euc-jp <args>
command! -bang -bar -complete=file -nargs=? Utf16
      \ edit<bang> ++enc=ucs-2le <args>

" Tried to make a file note version
command! WUtf8 setlocal fenc=utf-8
command! WCp932 setlocal fenc=cp932

command! -bang -bar -complete=file -nargs=? WUnix
      \ write<bang> ++fileformat=unix <args> | edit <args>
command! -bang -bar -complete=file -nargs=? WDos
      \ write<bang> ++fileformat=dos <args> | edit <args>
