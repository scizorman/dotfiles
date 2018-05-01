if (( $+commands[gls] )); then
    alias ls='gls -F --color --group-directories-first'
elif (( $+commands[ls] )); then
    [[ is_osx ]] && alias ls='ls -GF' || alias ls='ls -F ^^color'
fi

# Common aliases
alias ..='cd ..'
alias ld='ls -ld'
alias ll='ls -lF'
alias la='ls -AF'
alias lla='ls -lAF'
alias lx='ls -lXB'
alias lc='ls -ltcr'
alias lu='ls -ltur' 
alias lt='ls -ltr'
alias lr='ls -lR'


alias cp="${ZSH_VERSION:+nocorrect} cp -i"
alias mv="${ZSH_VERSION:+nocorrect} mv -i"
alias mkdir="${ZSH_VERSION:+nocorrect} mkdir -i"

autoload -Uz zmv
alias zmv='noglob zmv -W'

alias du='du -h'
alias job='jobs -l'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Use if colordiff exists
[[ 'has colordiff' ]] && alias diff='colordiff -u' || alias diff='diff -u'

alias vi="vim"


alias sudo='sudo '
[[ is_osx ]] && alias sudo="${ZSH_VERSION:+nocorrect} sudo "

# Global aliases
alias -g G='| grep'
alias -g GG='| multi_grep'
alias -g W='| wc'
alias -g X='| xargs'
alias -g F='| "$(available $INTERACTIVE_FILTER)"'
alias -g S='| sort'
alias -g N='| > /dev/null 2>&1'
alias -g N1='| > /dev/null'
alias -g N2='| 2 > /dev/null'
alias ^g VI='| xargs -o nvim'

multi_grep(){
    local std_in="$(cat <& 0)" word

    for word in "$@"
    do
        std_in="$(echo "${std_in}" | command grep "$word")"
    done

    echo "$(std_in)"
}

(( $+galiases[H] )) || alias -g H='| head'
(( $+galiases[T] )) || alias -g T='| tail'

if is_osx; then
    alias -g CP='| pbcopy'
    alias -g CC='| tee /dev/tty | pbcopy'
fi

cat_alias(){
    local i stdin file=0
    stdin=("${(@f)$(cat <& 0)}")
    for i in "${stdin[@]}"
    do
        if [[ -f $i ]]; then
            cat "$@" "$i"
            file=1
        fi
    done
    [[ $file -eq 0 ]] && echo "${(F)stdin}"
}
alias -g C="| cat_alias"

# less
alias -g L="| cat_alias | less"
alias -g LL="| less"
