" Specifies the type of list to use for command outputs
let g:go_list_type = "locationlist"
let g:go_list_type_commands = {"GoInstall": "quickfix", "GoBuild": "quickfix", "GoTest": "quickfix"}
let g:go_list_autoclose = 1
let g:go_list_height = 10

" Disable it will jump to the first error automatically
let g:go_jump_to_error = 0

" Disable running build and test command in terminal
let g:go_term_enabled = 0
let g:go_term_mode = "split"
let g:go_term_height = "10"

" go highlights
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

" Highlight all uses of the identifier under the cursor
" |:GoSameIds| automatically
let g:go_auto_sameids = 0

" Description of the identifier under the cursor
let g:go_auto_type_info = 0

augroup GoCommands
    autocmd!
    autocmd FileType go nmap <silent><LocalLeader>gr <Plug>(go-run)
    autocmd FileType go nmap <silent><LocalLeader>gb <Plug>(go-build)
    autocmd FileType go nmap <silent><LocalLeader>gtt <Plug>(go-test)
    autocmd FileType go nmap <silent><LocalLeader>gtf <Plug>(go-test-func)
    autocmd FileType go nmap <silent><LocalLeader>gm <Plug>(go-imports)
    autocmd FileType go nmap <silent><LocalLeader>gi <Plug>(go-install)
    autocmd FileType go nmap <silent><LocalLeader>gdd <Plug>(go-doc)
    autocmd FileType go nmap <silent><LocalLeader>gdb <Plug>(go-doc-browser)
augroup END
