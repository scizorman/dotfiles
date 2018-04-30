umask 022
limit coredumpsize 0
bindkey -d

# Return if zsh is called from vim
if [[ -n $VIMRUNTIME ]]; then
    return 0
fi


# Automatically attach tmux session when you are in zsh
if [[ -x $HOME/bin/tmuxx ]]; then
    $HOME/bin/tmuxx
fi

if [[ -f $HOME/.zplug/init.zsh ]]; then
    export ZPLUG_LOADFILE=$HOME/.zsh/zplug.zsh
    source $HOME/.zplug/init.sh

    if ! zplug check --verbose; then
        printf "Install? [y/n]: "
        if read -q; then
            echo; zplug install
        fi
        echo
    fi
    zplug load
fi

if [[ -f $HOME/.zshrc.local ]]; then
    source $HOME/.zshrc.local
fi
