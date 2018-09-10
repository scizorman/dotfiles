func plugs#go#hook_source()
  let g:go_list_type = "quickfix"
  let g:go_info_mode = 'gocode'
  let g:go_fmt_autosave = 1
  let g:go_fmt_command = 'gofmt'

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
