#!/usr/bin/env zsh
# Do not run the startup files /etc/zshenv, /etc/zprofile, ...
setopt no_global_rcs

# Directory of the startup files
export ZDOTDIR="$HOME/.zsh"

# XDG Base Directory
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share

# Language
export LANG='en_US.UTF-8'

# Editor
export EDITOR='nvim'

# Pager
export PAGER='less'

# Less status line
export LESS='-R -f -X -i -P ?f%f: (stdin). ?lb%lb?L/%L.. [?eEOF:?pb%pb\%..]'

# Less man page colors (makes Man pages more readable)
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[00;43;30m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# ls command color
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# Declare the environment variables
export CORRECT_IGNORE='_*'
export CORRECT_IGNORE_FILE='.*'

export WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"


# History
export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=10000
export SAVEHIST=1000000

if [[ $UID == 0 ]]; then
  unset HISTFILE
  export SAVEHIST=0
fi

# fzf: command-line fuzzy finder
export FZF_DEFAULT_OPTS='
  --extended
  --ansi
  --multi
  --border
  --reverse
'
