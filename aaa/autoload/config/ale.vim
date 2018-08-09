function config#ale()
    " Mappings
    nmap <silent> <Leader>aj <Plug>(ale_next)
    nmap <silent> <Leader>ak <Plug>(ale_previous)

    " Disable at startup
    let g:ale_enabled = 1

    " Appearance
    let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
    let g:ale_sign_column_always = 1
    let g:ale_set_highlights = 0

    " Event of lint enter
    let g:ale_lint_on_enter = 1
    let g:ale_lint_on_save = 1
    let g:ale_lint_on_text_changed = 'never'

    " Quickfix and Loclist
    let g:ale_set_loclist = 0
    let g:ale_set_quickfix = 0
    let g:ale_open_list = 0
    let g:ale_keep_list_window_open = 0

    let g:ale_statusline_format = ['%d Error', '%d Warn', 'OK']

    " Enable linter
    let g:ale_linter = {
    \     'c': ['clang'],
    \     'cpp': ['clang'],
    \     'objc': ['clang'],
    \     'objcpp': ['clang'],
    \     'h': ['clang'],
    \     'python': ['flake8'],
    \     'go': ['gofmt'],
    \     'typescript': ['eslint'],
    \     'javascript': ['eslint'],
    \     'html': ['HTMLHint'],
    \     'css': ['stylelint'],
    \     'sass': ['stylelint'],
    \     'scss': ['stylelint'],
    \     'dockerfile': ['hadolint'],
    \     'shell': ['shellcheck'],
    \     'vim': ['vint'],
    \     'markdown': ['mdl'],
    \ }
endfunction
