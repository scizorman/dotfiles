#!/usr/local/bin/zsh
umask 022
limit coredumpsize 0
bindkey -d

# Return if zsh is called from vim
if [[ -n $VIMRUNTIME ]]; then
    return 0
fi

# tmux_automaticcaly_attach attaches tmux session
# automatically when you are in zsh
if [[ -x $HOME/bin/tmux_automatically_attach ]]; then
    $HOME/bin/tmux_automatically_attach
fi

# zplug
if [ ! -e $HOME/.zplug ]; then
    git clone https://github.com/zplug/zplug $HOME/.zplug
fi

if [[ -f $HOME/.zplug/init.zsh ]]; then
    export ZPLUG_LOADFILE=$HOME/.zsh/zplug.zsh
    source $HOME/.zplug/init.zsh

    if ! zplug check --verbose; then
        printf "Install? [y/n]: "
        if read -q; then
            echo; zplug install
        fi
        echo
    fi
    zplug load --verbose
fi

[[ -f $HOME/.zshrc.local ]] && source $HOME/.zshrc.local

# Benchmark
# alias zbench='for i in $(seq 1 10); do time zsh -i -c exit; done'
#
# fzf
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
