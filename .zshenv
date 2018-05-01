#!/usr/local/bin/zsh
# PATH
typeset -gx -U path
path=( \
    /usr/local/{bin,sbin}(N-/) \
    $HOME/bin(N-/) \
    $HOME/.zplug/bin(N-/) \
    $HOME/.tmux/bin(N-/) \
    "$path[@]" \
)

# FPATH
# NOTE: set fpath before compinit
typeset -gx -U fpath
fpath=( \
    $HOME/.zsh/Completion(N-/) \
    $HOME/.zsh/functions(N-/) \
    $HOME/.zsh/plugins/zsh-completions(N-/) \
    /usr/local/share/zsh/site-functions(N-/) \
    $fpath \
)

# autoload
autoload -Uz run-help
autoload -Uz add-zsh-hook
autoload -Uz colors && colors
autoload -Uz compinit && compinit -u
autoload -Uz is-at-least

# LANGUAGE (en_US)
export LANGUAGE=en_US.UTF-8
export LANG=$LANGUAGE
export LC_ALL=$LANGUAGE
export LC_CTYPE=$LANGUAGE

# Editor
export EDITOR=vim
export CVSEDITOR=$EDITOR
export SVN_EDITOR=$EDITOR
export GIT_EDITOR=$EDITOR

# Neovim
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share

# Pager
export PAGER=less

# Less status line
export LESS='-R -f -X -i -P ?f%f: (stdin). ?lb%lb?L/%L.. [?eEOF:?pb%pb\%..]'
export LESSCHARSET='utf-8'

# LESS man page colors (makes Man pages more readable).
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[00;43;30m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# ls command colors
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

setopt no_global_rcs

# Add ~/bin to PATH
# export PATH=$HOME/bin:$PATH

# Declare the environment variables
export CORRECT_IGNORE='_*'
export CORRECT_IGNORE_FILE='.*'

export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
export WORDCHARS='*?.[]~&;!#$%^(){}<>'

# History file and its size
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=1000000
export LISTMAX=50

if [[ $UID == 0 ]]; then
    unset HISTFILE
    export SAVEHIST=0
fi

# fzf -command-line fuzzy finder (https://github.com/junegunn/fzf)
export FZF_DEFAULT_OPTS="--extended -ansi -multi"

# Available $INTERACTIVE_FILTER
# export INTRACTIVE_FILTER="fzf:peco:percol:gof:pick"

export DOTPATH=${0:A:h}
