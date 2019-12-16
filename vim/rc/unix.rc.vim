" ----------------------------------------------------------------------------- Unix
" -----------------------------------------------------------------------------
if has('gui_running')
  finish
endif

set t_Co=256

" Enable true color.
if exists('+termguicolors')
  set termguicolors
endif
