let g:plug = {
  \ 'plug': g:config.path.vim . '/autoload/plug.vim',
  \ 'base': g:config.path.vim . '/plugged',
  \ 'url': 'https://raw.github.com/juneguun/vim-plug/master/plug.vim',
  \ 'github': 'https://github.com/juneguun/vim-plug',
}

function! g:plug.ready()
  return filereadable(self.plug)
endfunction

if g:plug.ready() && g:config.vimrc.plugin_on
  call plug#begin(g:plug.base)

  call 'juneguun/vim-plug', {'dir': g:plug.base}

  Plug 'Shougo/vimproc.vim', {'do': 'make'}
  Plug 'thinca/vim-quickrun'
  
  " Deoplete
  Plug 'Shougo/deoplete.nvim'
  Plug 'zchee/deoplete-jedi', {'for': 'python'}
  Plug 'zchee/deoplete-go', {'for': 'go'}
  Plug 'zchee/deoplete-docker', {'for': 'dockerfile'}
  Plug 'zchee/deoplete-zsh', {'for': ['sh', 'zsh']}
  Plug 'Shougo/neco-vim', {'for', 'vim'}
  Plug 'Shougo/neoinclude.vim'
  Plug 'Shougo/neosnippet-snippets'
  Plug 'Shougo/neosnippet.vim', {'for': 'snippet'}

  " Denite
  Plug 'Shougo/denite.nvim'
  Plug 'Shougo/neomru.vim'

  " Git
  Plug 'tpope/vim-fugitive',
    \ {'on': ['Git', 'Gcommit', 'Gstatus', 'Gdiff', 'Gblame', 'Glog']}
  Plug 'airblade/vim-gitgutter'

  " Linter
  Plug 'w0rp/ale', {
    \ 'for': [
      \ 'python',
      \ 'go',
      \ 'dockerfile',
      \ 'sh',
      \ 'zsh',
      \ 'vim',
    \ ]
  \ }

  " Interface
  Plug 'cocopon/vaffle.vim'
  Plug 'itchyny/lightline.vim'

  " Utility

  " Color scheme
  Plug 'cocopon/iceberg.vim'
  Plug 'jacoborus/tender.vim'

  call plug#end()
endif

" Add plug's plugins
let g:plug.plugs = get(g:, 'plugs', {})
let g:plug.list = keys(g:plug.plugs)

if !g:plug.ready()
  function! g:plug.init()
    let ret = system(printf('curl -fLo %s --create-dirs %s'), self.plug, self.url)
    if v:shell_error
      return Error('g:plug.init: Error occured.')
    endif

    " Restart vim
    if !g:config.is_gui
      silent! !vim
      quit!
    endif
  endfunction

  command! PlugInit call g:plug.init()

  if g:config.vimrc.suggest_vimplug_init == g:true
    autocmd! VimEnter * redraw
      \ | echohl WarningMsg
      \ | echo "You shoud do ':PlugInit' at first."
      \ | echohl None
  else
    " Install vim-plug
    PlugInit
  endif
endif

function! g:plug.is_installed(strict, ...)
  let list = []
  if type(a:strict) != type(0)
    call add(list, a:strict)
  endif
  let list += a:000

  for arg in list
    let name = substitute(arg, '^vim-\|\.vim$', "", "g")
    let prefix = 'vim-' . name
    let suffix = name . '.vim'

    if a:strict == 1
      let name = arg
      let prefix = arg
      let suffix = arg
    endif

    if has_key(self.plugs, name)
      \ ? isdirectory(self.plugs[name].dir)
      \ : has_key(self.plugs, prefix)
      \ ? isdirectory(self.plugs[prefix].dir)
      \ : has_key(self.plugs, suffix)
      \ ? isdirectory(self.plugs[suffix].dir)
      \ : g:false
      continue
    else
      return g:false
    endif
  endfor

  return g:true
endfunction

function! g:plug.is_rtp(p)
  return index(split(&runtimepath, ','), get(self.plugs[a:p], 'dir')) != -1
endfunction

function g:plug.is_loaded(p)
  return g:plug.is_installed(1, a:p) && g:plug.is_rtp(a:p)
endfunction

function g:plug.check_installation()
  if empty(self.plugs)
    return
  endif

  let list = []
  for [name, spec] in items(self.plugs)
    if !isdirectory(spec.dir)
      call add(list, spec.url)
    endif
  endfor

  if len(list) > 0
    let unplugged = map(list, 'substitute(v:val, "^.*github\.com/\\(.*/.*\\)\.git$", "\\1", "g")')

    PlugInstall
  endif
endfunction

if g:plug.ready() && g:config.vimrc.plugin_on
  function! PlugList(A,L,P)
    return join(g:plug.list, '\n')
  endfunction

  command! -nargs=1 -complete=custom,PlugList PlugHas
    \ if g:plug.is_installed('<args>')
    \ | echo g:plug.plugs['<args>'].dir
    \ | endif
endif
