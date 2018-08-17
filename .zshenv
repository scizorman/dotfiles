#!/usr/bin/env zsh
# For tuning
# NOTE: Disable if you don't tune Zsh.
# zmodload zsh/zprof && zprof


# -----------------------------------------------------------------------------
# Paths
# -----------------------------------------------------------------------------
typeset -gx -U path fpath

# PATH
path=( \
  /usr/local/{bin,sbin}(N-/) \
  $HOME/bin(N-/) \
  $HOME/.zplug/bin(N-/) \
  "$path[@]" \
)

# FPATH
# NOTE: Set fpath before compinit
fpath=( \
  $HOME/.zsh/completion(N-/) \
  $HOME/.zsh/plugins/zsh-completions(N-/) \
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
# Golang
# -----------------------------------------------------------------------------
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$GOPATH:$PATH


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
