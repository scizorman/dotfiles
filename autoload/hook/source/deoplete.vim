function hook#source#deoplete#config()
  " core
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
  call deoplete#custom#source('go', 'sorters', [])
  call deoplete#custom#source('buffer', 'rank', 0)
  call deoplete#custom#source('neosnippet', 'rank', 0)
  call deoplete#custom#source('jedi', 'disable_syntaxes', ['Comment'])
  call deoplete#custom#source('vim', 'disable_syntaxes', ['Comment'])
  call deoplete#custom#source('LanguageClient', 'disable_syntaxes', ['Comment'])
  call deoplete#custom#source('LanguageClient', 'matchers', ['match_head'])
  call deoplete#custom#source('LanguageClient', 'min_pattern_length', 1)

  " source
  " LLVM library path
  if isdirectory('/opt/llvm/devel/lib')
    let s:llvm_library_path = '/opt/llvm/devel/lib'
    let s:llvm_clang_version = '8.0.0'
  elseif isdirectory('/opt/llvm/stable/lib')
    let s:llvm_library_path = '/opt/llvm/stable/lib'
    let s:llvm_clang_version = '6.0.0'
  else
    let s:llvm_library_path = '/Library/Developer/CommandLineTools/usr/lib'
    let s:llvm_clang_version = '10.0.0'
  endif

  " clang
  let g:deoplete#sources#clang#clang_header = s:llvm_library_path . '/clang'
  let g:deoplete#sources#clang#flag = [
       \ '-I/usr/local/include',
       \ '-I/' . s:llvm_library_path . '/clang/' . s:llvm_clang_version . '/include',
       \ '-I/usr/include',
       \ '-F/System/Library/Frameworks',
       \ '-F/Library/Frameworks',
       \ '-isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk',
       \ ]
  let g:deoplete#sources#clang#libclang_path = s:llvm_library_path . '/libclang.dylib'

  " go
  let g:deoplete#sources#go#gocode_binary = expand($GOPATH . '/bin/gocode')
  let g:deoplete#sources#go#flags = []
  let g:deoplete#sources#go#auto_goos = 1
  let g:deoplete#sources#go#pointer = 1
  let g:deoplete#sources#go#sort_class = ['func', 'type', 'var', 'const', 'package']
  " let g:deoplete#sources#go#cgo = 1
  " let g:deoplete#sources#go#cgo#libclang_path = s:llvm_library_path . '/clang'
  " let g:deoplete#sources#go#cgo#sort_algo = 'priority'

  " jedi
  let g:deoplete#sources#jedi#python_path = g:python3_host_prog
  let g:deoplete#sources#jedi#short_types = 0
  let g:deoplete#sources#jedi#show_docstring = 1
  let g:deoplete#sources#jedi#statement_length = 0
  let g:deoplete#sources#jedi#worker_threads = 4
endfunction
