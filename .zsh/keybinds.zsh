# Vim-like keybind as default
bindkey -v
# Escape 'jj'
bindkey -M viins 'jj' vim-cmd-mode

# Add emacs-like keybind to viins mode
bindkey -M viins '^F' forward-char
bindkey -M viins '^B' backward-char
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line
bindkey -M viins '^K' kill-line
bindkey -M viins '^Y' yank
bindkey -M viins '^W' backward-kill-word
bindkey -M viins '^U' backward-kill-line
bindkey -M viins '^H' backward-delete-char
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^G' send-break
bindkey -M viins '^D' delete-char-or-list

if is-at-least 5.0.8; then
    autoload -Uz surround
    zle -N delete-surround surround
    zle -N change-surround surround
    zle -N add-surround surround
    bindkey -a cs change-surround
    bindkey -a ds delete-surround
    bindkey -a ys add-surround
    bindkey -a S add-surround
fi

if false; then
    # Bind P and N for Emacs mode
    has 'history-substring-search-up' && bindkey -M emacs '^P' history-substring-search-up
    has 'history-substring-search-down' && bindkey -M emacs '^N' history-substring-search-down

    # Bind k and j for Vi mode
    has 'history-substring-search-up' && bindkey -M vicmd 'k' history-substring-search-up
    has 'history-substring-search-down' && bindkey -M vicmd 'j' history-substring-search-down

    # Bind P and N keys
    has 'history-substring-search-up' && bindkey '^P' history-substring-search-up
    has 'history-substring-search-down' && bindkey '^N' history-substring-search-down
fi

# Insert a last word
zle -N insert-last-word smart-insert-last-word
zstyle :insert-last-word match '*([^[:space:]][[:alpha:]/\\]|[[:alpha:]/\\][^[:space:]])*'
bindkey -M viins '^]' insert-last-word

# Surround a forward word by single quote
quote-previous-word-in-single(){
    modify-current-argument '${(qq)${(Q)ARG}}'
    zle vi-forward-blank-word
}
zle -N quote-previous-word-in-single
bindkey -M viins '^Q' quote-previous-word-in-single

# Surround a forward word by double quote
quote-previous-word-in-double(){
    modify-current-argument '${(qqq)${(Q)ARG}}'
    zle vi-forward-blank-word
}
zle -N quote-previous-word-in-double
bindkey -M viins '^Xq' quote-previous-word-in-double

bindkey -M viins "$terminfo[kcbt]" reverse-menu-complete


################
# Functions
################
_delete-char-or-list-expand(){
    [ -z "$RBUFFER" ] && zle list-expand || zle delete-char
}
zle -N _delete-char-or-list-expand
bindkey '^D' _delete-char-or-list-expand

# Ctrl-R
_peco-select-history(){
    if true; then
        BUFFER="$(
            history 1 \
                | sort -k1,1nr \
                | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' \
                | fzf --query "$LBUFFER"
        )"

        CURSOR=$#BUFFER
        zle reset-prompt
    else
        if is-at-least 4.3.9; then
            zle -la history-incremental-pattern-search-backward && bindkey "^r" history-incremental-pattern-search-backward
        else
            history-incremental-search-backward
        fi
    fi
}

_start-tmux-if-not-already-started(){
    BUFFER="${${${(M)${+commands[tmuxx]}#1}:+tmuxx}:-tmux}"
    if has "tmux_automaticcaly_attach"; then
        BUFFER="tmux_automaticcaly_attach"
    fi
    CURSOR=$#BUFFER
    zle accept-line
}
zle -N _start-tmux-if-not-already-started
if ! is_tmux_running; then
    bindkey '^T' _start-tmux-if-not-already-started
fi

do_enter(){
    if [[ -n $BUFFER ]]; then
        zle accept-line
        return $status
    fi

    : ${ls_done:=fale}
    : ${git_ls_done:=false}

    if [[ $PWD != $GIT_OLDPWD ]]; then
        git_ls_done=false
    fi

    echo 
    if is_git_repo; then
        if $git_ls_done; then
            [[ -n $(git status --short) ]] && git status
        else
            ${=aliases[ls]} && git_ls_done=true
            GIT_OLDPWD=$PWD
        fi
    else
        if [[ $PWD != $OLDPWD ]] && ! $ls_done; then
            ${=aliases[ls]} && ls_done=true
        fi
    fi

    zle reset-prompt
}
zle -N do-enter
bindkey '-m' do-enter

peco-select-gitadd(){
    local selected_file_to_add
    selected_file_to_add="$(
        git status --porcelain \
            | perl -pe 's/^( ?.{1,2} )(.*)$/\033[31m$1\033[m$2' \
            | fzf --ansi --exit-0 \
            | awk -F ' ' '{print $NF}' \
            | tr "\n" " "
    )"

    if [ -n "$selected_file_to_add" ]; then
        BUFFER="git add $selected_file_to_add"
        CURSOR=$#BUFFER
        zle accept-line
    fi
    zle reset-prompt
}
zle -N peco-select-gitadd
bindkey '^g^a' peco-select-gitadd

exec-oneliner(){
    local oneliner_f
    oneliner_f="${ONELINER_FILE:-~/.command.list}"

    [[ ! -f $oneliner_f || ! -s $oneliner_f ]] && return 

    local cmd q k res accept
    while accept=0; cmd="$(
        cat < $oneliner_f \
            | sed -e '/^#/d;/^$/d' \
            | perl -pe 's/^(\[.*?\]) (.*)$/$1\t$2/' \
            | perl -pe 's/(\[.*?\])/\033[31m$1\033[m/' \
            | perl -pe 's/^(: ?)(.*)$/$1\033[30;47;1m$2\033[m/' \
            | perl -pe 's/^(.*)([[:blank:]]#[[:blank:]]?.*)$/$1\033[30;1m$2\033[m/' \
            | perl -pe 's/(!)/\033[31;1m$1\033[m/' \
            | perl -pe 's/(\|| [A-Z]+ [A-Z]+| [A-Z]+ )/\033[35;1m$1\033[m/g' \
            | fzf --ansi --multi --no-sort --tac --query="$q" \
            --print-query --expect=ctrl-v --exit-0
        )"; do
        q="$(head -1 <<< "$cmd")"
        q="$(head -2 <<< "$cmd" | tail -1)"
        res="$(sed '1,2d;/^$/d;s/[[:blank:]]#.*$//' <<< "$cmd")"
        [ -z "$res" ] && continue
        if [ "$k" = "ctrl-V" ]; then
            vim "$oneliner_f" < /dev/tty > /dev/tty
        else
            cmd="$(perl -pe 's/^(\[.*?\])\t(.*)$/$2/')"
            if [[ $cmd =~ "!$" || $cmd =~ "! *#.*$" ]]; then
                accept=1
                cmd="$(sed -e 's/!.*$//' <<< "$cmd")"
            fi
            break
        fi
    done

    local len
    if [[ -n $cmd ]]; then
        BUFFER="$(tr -d '@' <<< "$cmd" | perl -pe 's/\n/; /' | sed -e 's/; $//')"
        len="${cmd%%@*}"
        CURSOR=${#len}
        if [[ $accept -eq 1 ]]; then
            zle accept-line
        fi
    fi

    zle redisplay
}
zle -N exec-one-liner
bindkey '^x^x' exec-oneliner

globalias(){
    if [[ $LBUFFER =~ ' [A-z0-9]+$' ]]; then
        zle _expand_alias
    fi
    zle self-insert
}
zle -N globalias
bindkey " " globalias
