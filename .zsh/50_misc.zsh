#
# Completion
#
autoload -Uz compinit
_comp_files=(${ZDOTDIR:-$HOME}/.zcompdump(Nm-20))
if (( $#_comp_files )); then
    compinit -i -C
else
    compinit -i
fi
unset _comp_files

# Styles
# Completing grouping
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''

# Completing misc
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'
zstyle ':completion:*' use-cache true
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Directory
zstyle ':completion:*:cd:*' ignored-parents parent pwd
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}


# 
# History
#
HISTFILE="${ZDOTDIR:-$HOME}/.zhistory"
HISTSIZE=10000
SAVEHIST=10000

if [[ $UID == 0 ]]; then
    unset HISTFILE
    export SAVEHIST=0
fi


#
# etc.
#
# Automaticall escape URO when copy and paste.
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Menu select
# zmodload -i zsh/complist
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^j' vi-down-line-or-history
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char

autoload -Uz cdr
autoload -Uz history-search-end
autoload -Uz modify-current-argument
autoload -Uz smart-insert-last-word
autoload -Uz terminfo
autoload -Uz zcalc
autoload -Uz zmv
autoload -Uz run-help-git

# jeneguun/fzf
export FZF_DEFAULT_OPTS='
    --extended
    --ansi
    --multi
    --bind=ctrl-u:page-up
    --bind=ctrl-d:page-down
    --bind=ctrl-z:toggle-all
'
