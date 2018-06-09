#!/usr/bin/env zsh
#
# Browser
#
if [[ "$OSTYPE" == darwin* ]]; then
    export BROWSER='open'
fi


#
# Editors
#
export EDITOR='vim'

# Neovim
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share


#
# Language
#
if [[ -z "$LANG" ]]; then
    export LANG='en_US.UTF-8'
fi


#
# Paths
#
typeset -gU path fpath

# PATH
path=(
    /usr/local/{bin,sbin}(N-/)
    $HOME/bin(N-/)
    $HOME/.zplug/bin(N-/)
    $path
)

# FPATH
# NOTE: Set fpath before compinit
fpath=(
    $HOME/.zsh/completion(N-/)
    $HOME/.zsh/plugins/zsh-completions(N-/)
    /usr/local/share/zsh/site-functions(N-/)
    $fpath
)


# 
# Pager
#
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

# 
# etc.
#
# ls command color
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# autoload
autoload -Uz run-help
autoload -Uz colors && colors
autoload -Uz is-at-least
