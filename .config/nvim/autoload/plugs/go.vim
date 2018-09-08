func plugs#go#hook_source()
  let go#highlight#cgo = 1
  let g:go#build#autosave = 1
  let g:go#build#flags = ['-race']
  let g:go#build#force = 0
  let g:go#fmt#autosave = 1
  let g:go#fmt#mode = 'goimports'
  let g:go#guru#keep_cursor = {
        \ 'callees' : 0,
        \ 'callers' : 0,
        \ 'callstack': 0,
        \ 'definition': 1,
        \ 'describe': 0,
        \ 'freevars': 0,
        \ 'implements': 0,
        \ 'peers': 0,
        \ 'pointsto': 0,
        \ 'referrers': 0,
        \ 'whicherrs': 0
        \ }
  let g:go#guru#reflection = 0
  let g:go#iferr#autosave = 0
  let g:go#lint#golint#autosave = 0
  let g:go#lint#golint#ignore = ['internal']
  let g:go#lint#golint#mode = 'root'
  let g:go#lint#govet#autosave = 0
  let g:go#lint#govet#flags = ['-v', '-all', 'shadow']
  let g:go#lint#metalinter#autosave = 0
  let g:go#lint#metalinter#autosave#tools = ['vet', 'golint']
  let g:go#lint#metalinter#deadline = '20s'
  let g:go#lint#metalinter#skip_dir = ['internal', 'vendor', 'testdata', '__*.go', '*_test.go']
  let g:go#lint#metalinter#tools = ['vet', 'golint']
  let g:go#rename#prefill = 1
  let g:go#snippet#loaded = 1
  let g:go#terminal#height = 120
  let g:go#terminal#start_insert = 1
  let g:go#terminal#width = 120
  let g:go#test#all_package = 0
  let g:go#test#autosave = 0
  let g:go#test#flags = ['-v']
  let g:go#debug = 1
  let g:go#debug#pprof = 0

  " Highlight
  let g:go_highlight_array_whitespace_error = 0    " default: 1
  let g:go_highlight_build_constraints = 1
  let g:go_highlight_chan_whitespace_error = 0     " default: 1
  let g:go_highlight_extra_types = 1
  let g:go_highlight_fields = 0                    " default: 0
  let g:go_highlight_format_strings = 1
  let g:go_highlight_functions = 1                 " default: 0
  let g:go_highlight_generate_tags = 1             " default: 0
  let g:go_highlight_interfaces = 1                " default: 0
  let g:go_highlight_methods = 1                   " default: 0
  let g:go_highlight_operators = 1                 " default: 0
  let g:go_highlight_space_tab_error = 0           " default: 1
  let g:go_highlight_string_spellcheck = 0         " default: 1
  let g:go_highlight_structs = 1                   " default: 0
  let g:go_highlight_trailing_whitespace_error = 0 " default: 1
endfunction
