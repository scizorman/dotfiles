function hook#source#deoplete#config()
  let g:deoplete#enable_at_startup = 1

  let s:deoplete_custom_option = {
        \ 'auto_complete_delay': 0,
        \ 'auto_refresh_delay': 50,
        \ 'camel_case': v:false,
        \ 'ignore_case': v:true,
        \ 'ignore_sources': {
        \   '_': ['around', 'dictionary', 'omni', 'tag'],
        \   'c': ['around', 'dictionary', 'omni', 'tag', 'buffer', 'member', 'neosnippet'],
        \   'cpp': ['around', 'dictionary', 'omni', 'tag', 'buffer', 'member', 'neosnippet'],
        \   'go': ['around', 'dictionary', 'omni', 'tag', 'buffer', 'member', 'neosnippet', 'LanguageClient'],
        \   'python': ['around', 'dictionary', 'omni', 'tag', 'member', 'neosnippet', 'LanguageClient'],
        \   'sh': ['around', 'dictionary', 'omni', 'tag'],
        \   'bash': ['around', 'dictionary', 'omni', 'tag'],
        \   'zsh': ['around', 'dictionary', 'omni', 'tag'],
        \   'yaml': ['around', 'dictionary', 'omni', 'tag', 'neosnippet'],
        \   'yaml.docker-compose': ['around', 'dictionary', 'omni', 'tag', 'neosnippet'],
        \ },
        \ 'omni_patterns': {
        \   'c': '[^. *\t]\.\w*',
        \   'cpp': '[^. *\t]\.\w*',
        \   'sh': '[^ *\t"{=$]\w*',
        \   'yaml': '[^ *\t"{=$]\w*',
        \   'yaml.docker-compose': '[^ *\t"{=$]\w*',
        \ },
        \ 'max_list': 10000,
        \ 'min_pattern_length': 1,
        \ 'num_processes': 10,
        \ 'on_insert_enter': v:true,
        \ 'on_text_changed_i': v:true,
        \ 'refresh_always': v:false,
        \ 'skip_chars': ['(', ')'],
        \ 'smart_case': v:true,
        \ }
  call deoplete#custom#option(s:deoplete_custom_option)

  let s:deoplete_omni_input_patterns = {}
  call deoplete#custom#var('omni', 'input_patterns', s:deoplete_omni_input_patterns)

  call deoplete#custom#source('_', 'converters', ['converter_auto_paren', 'converter_remove_overlap'])
  call deoplete#custom#source('_', 'sorters', [])
  call deoplete#custom#source('buffer', 'rank', 0)
  call deoplete#custom#source('neosnippet', 'rank', 0)
  call deoplete#custom#source('vim', 'disable_syntaxes', ['Comment'])
  call deoplete#custom#source('LanguageClient', 'sorters', [])
  call deoplete#custom#source('LanguageClient', 'disable_syntaxes', ['Comment'])
  call deoplete#custom#source('LanguageClient', 'matchers', ['match_head'])
  call deoplete#custom#source('LanguageClient', 'min_pattern_length', 1)
endfunction
