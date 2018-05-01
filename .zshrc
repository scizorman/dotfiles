#!/usr/local/bin/zsh
umask 022
limit coredumpsize 0
bindkey -d

# Return if zsh is called from vim
[[ -n $VIMRUNTIME ]] && return 0

# tmux_automaticcaly_attach attaches tmux session
# automatically when you are in zsh
[[ -x $HOME/bin/tmuxx ]] && $HOME/bin/tmuxx

# zplug
if [[ -f $HOME/.zplug.init.zsh ]]; then
    export ZPLUG_LOADFILE=$HOME/.zsh/zplug.zsh
    source $HOME/.zplug/init.zsh

    if ! zplug check --verbose; then
        printf "Install? [y/n]: "
        if read -q; then
            echo; zplug install
        fi
        echo
    fi
    zplug load
fi

[[ -f $HOME/.zshrc.local ]] && source $HOME/.zshrc.local

# Detect OS
case "${(L):-$(uname)}" in
    darwin* )
        alias ls='ls -G' ;;
    linux* )
        [[ $TERM == 'xterm' ]] && export TERM='xterm-256color'
        alias ls='ls -color=auto' ;;
esac


# Benchmark
alias zbench='for i in $(seq 1 10); do time zsh -i -c exit; done'

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
