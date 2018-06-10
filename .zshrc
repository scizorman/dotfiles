#!/usr/bin/env zsh
umask 022
limit coredumpsize 0
bindkey -d

# Return if zsh is called from vim
if [[ -n $VIMRUNTIME ]]; then
    return 0
fi

# Attaches tmux session automatically when you are in zsh
if [[ -x $HOME/bin/tmux_automatically_attach ]]; then
    $HOME/bin/tmux_automatically_attach
fi

# zplug
if [[ -f $HOME/.zplug/init.zsh ]]; then
    export ZPLUG_LOADFILE=$HOME/.zsh/zplug.zsh
    source $HOME/.zplug/init.zsh

    # if ! zplug check --verbose; then
    if ! zplug check; then
        printf "Install? [y/n]: "
        if read -q; then
            echo; zplug install
        fi
        echo
    fi
    # zplug load --verbose
    zplug load
fi

if [[ -f $HOME/.zshrc.local ]]; then
    source $HOME/.zshrc.local
fi
