function plugs#deoplete#hook_source()
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#enable_camel_case = 0
  let g:deoplete#enable_ignore_case = 1
  let g:deoplete#enable_refresh_always = 0
  let g:deoplete#enable_smart_case = 1

  let g:deoplete#auto_complete_delay = 0
  let g:deoplete#auto_refresh_delay = 100
  let g:deoplete#max_list = 10000

  " ignore
  let g:deoplete#ignore_sources = {}
  let g:deoplete#ignore_sources._ = ['around']
  let g:deoplete#ignore_sources.c = [
  \ 'dictionary', 'member', 'omni', 'tag', 'syntax', 'file/include', 'neosnippet', 'around'
  \ ]
  let g:deoplete#ignore_sources.cpp = g:deoplete#ignore_sources.c
  let g:deoplete#ignore_sources.objc = g:deoplete#ignore_sources.c
  let g:deoplete#ignore_sources.python = [
  \ 'buffer', 'dictionary', 'member', 'omni', 'tag', 'syntax', 'around'
  \ ]
  let g:deoplete#ignore_sources.go = [
  \ 'buffer', 'dictionary', 'member', 'omni', 'tag', 'syntax', 'around'
  \ ]

  " omnifunc
  " let g:deoplete#omni#input_patterns = {}
  " let g:deoplete#omni#input_patterns.lua = ['\h\w*']
  " Gautocmdft python, go setlocal omnifunc=

  " clang
  let g:deoplete#sources#clang#libclang_path = '/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'
  let g:deoplete#sources#clang#clang_header = '/Library/Developer/CommandLineTools/usr/lib/clang'

  " go
  let g:deoplete#sources#go#auto_goos = 1
  let g:deoplete#sources#go#cgo = 1
  let g:deoplete#sources#go#cgo#libclang_path = '/usr/local/Cellar/llvm/6.0.1/lib/libclang.dylib'
  let g:deoplete#sources#go#cgo#sort_algo = 'priority'
  let g:deoplete#sources#go#gocode_binary = $GOPATH . '/bin/gocode'
  let g:deoplete#sources#go#package_dot = 0
  let g:deoplete#sources#go#pointer = 1
  let g:deoplete#sources#go#sort_class = ['func', 'type', 'var', 'const', 'package']
  let g:deoplete#sources#go#use_cache = 0

  " jedi
  let g:deoplete#sources#jedi#python_path = g:python3_host_prog
  let g:deoplete#sources#jedi#short_type = 0
  let g:deoplete#sources#jedi#show_docstring = 1
  let g:deoplete#sources#jedi#statement_length = 0
  let g:deoplete#sources#jedi#worker_threads = 2
endfunction
