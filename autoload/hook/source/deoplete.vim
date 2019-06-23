function hook#source#deoplete#config()
  " <TAB>: completion
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ deoplete#manual_complete()
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~? '\s'
  endfunction

  " <S-TAB>: completion back
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  call deoplete#custom#source('_', 'matchers',
        \ ['matcher_fuzzy', 'matcher_length'])

  call deoplete#custom#source('_', 'converters', [
        \ 'converter_remove_paren',
        \ 'converter_remove_overlap',
        \ 'matcher_length',
        \ 'converter_truncate_abbr',
        \ 'converter_truncate_info',
        \ 'converter_truncate_menu',
        \ 'converter_auto_delimiter',
        \ ])

  call deoplete#custom#option({
        \ 'auto_refresh_delay': 10,
        \ 'camel_case': v:true,
        \ 'prev_completion_mode': 'none',
        \ 'skip_multibyte': v:true,
        \ })

  let s:default_ignore_sources = ['around', 'buffer']
  call deoplete#custom#source('ignore_sources', {
        \ '_': s:default_ignore_sources + ['LanguageClient'],
        \ 'go': s:default_ignore_sources,
        \ 'python': s:default_ignore_sources,
        \ 'javascript': s:default_ignore_sources,
        \ 'typescript': s:default_ignore_sources,
        \ 'vue': s:default_ignore_sources,
        \ 'c': s:default_ignore_sources,
        \ 'cpp': s:default_ignore_sources,
        \ })

  call deoplete#custom#option('keyword_patterns', {
        \ '_': '[a-zA-Z_]\k*\(?',
        \ 'tex': '[^\w|\s][a-zA-Z_]\w*',
        \ })

  call deoplete#enable()
endfunction
