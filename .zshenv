#!/usr/bin/env zsh
# For tuning
# NOTE: Disable if you don't tune Zsh.
# zmodload zsh/zprof && zprof

# zmodload zsh/zpty

# -----------------------------------------------------------------------------
# Paths
# -----------------------------------------------------------------------------
typeset -gx -U path fpath

# PATH
path=( \
  # /usr/local/bin(N-/) \
  $HOME/bin(N-/) \
  $HOME/.zplug/bin(N-/) \
  "$path[@]" \
) 

# FPATH
# NOTE: Set fpath before compinit
fpath=( \
  $HOME/.zsh/completions(N-/) \
  # $HOME/.zsh/plugins/zsh-completions(N-/) \
  /usr/local/share/zsh/site-functions(N-/) \
  $fpath \
)


# -----------------------------------------------------------------------------
# autoload
# -----------------------------------------------------------------------------
autoload -Uz run-help
autoload -Uz add-zsh-hook
autoload -Uz colors && colors
autoload -Uz is-at-least


# -----------------------------------------------------------------------------
# Browser
# -----------------------------------------------------------------------------
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi


# -----------------------------------------------------------------------------
# Editor
# -----------------------------------------------------------------------------
export EDITOR='nvim'
export CVSEDITOR="${EDITOR}"
export SVN_EDITOR="${EDITOR}"
export GIT_EDITOR="${EDITOR}"

# Neovim
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share


# -----------------------------------------------------------------------------
# Language
# -----------------------------------------------------------------------------
export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"


# -----------------------------------------------------------------------------
# Programming Languages
# -----------------------------------------------------------------------------
# Go
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT:$PATH"

export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
export GO15VENDOREXPERIMENT=1

# Python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT:$PATH"

# -----------------------------------------------------------------------------
# Pager
# -----------------------------------------------------------------------------
export PAGER='less'

# Less status line
export LESS='-R -f -X -i -P ?f%f: (stdin). ?lb%lb?L/%L.. [?eEOF:?pb%pb\%..]'

# Less man page colors (makes Man pages more readable).
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[00;43;30m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'


# -----------------------------------------------------------------------------
# History
# -----------------------------------------------------------------------------
export HISTFILE="${ZDOTDIR:-$HOME}/.zhistory"
export HISTSIZE=10000
export SAVEHIST=1000000

if [[ $UID == 0 ]]; then
  unset HISTFILE
  export SAVEHIST=0
fi


# -----------------------------------------------------------------------------
# etc.
# -----------------------------------------------------------------------------
# fzf: command-line fuzzy finder (https://github.com/juneguun/fzf)
export FZF_DEFAULT_OPTS='
  --extended
  --ansi
  --multi
  --bind=ctrl-u:page-up
  --bind=ctrl-d:page-down
  --bind=ctrl-z:toggle-all
'

# ls command color
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# Declare the environment variables
export CORRECT_IGNORE='_*'
export CORRECT_IGNORE_FILE='.*'

export WORDCHARS='*?.[]~&;!#$%^(){}<>'

# gettext
export PATH="/usr/local/opt/gettext/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/gettext/lib"
export CPPFLAGS="-I/usr/local/opt/gettext/include"

# Openssl
export PATH="/usr/local/opt/openssl/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"

# pkgconfig
export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"

# readline
export LDFLAGS="-L/usr/local/opt/readline/lib"
export CPPFLAGS="-I/usr/local/opt/readline/include"
