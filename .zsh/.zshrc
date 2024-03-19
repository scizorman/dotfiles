#!/usr/bin/env zsh
umask 022
limit coredumpsize 0

# FPATH
# NOTE: Set fpath before compinit
typeset -gxU fpath FPATH
fpath=( \
  $HOME/.zsh/completions(N-/) \
  $fpath \
)

# zcalc
autoload -Uz zcalc

# sheldon
autoload -Uz compinit && compinit
eval "$(sheldon source)"


# Options
# NOTE: T.B.D
# Completion
setopt always_last_prompt
setopt always_to_end
setopt auto_list
setopt auto_menu
setopt auto_param_keys
setopt auto_param_slash
setopt auto_remove_slash
setopt complete_in_word
setopt list_types
unsetopt list_beep
unsetopt menu_complete

# Expansion and Globbing
setopt brace_ccl
setopt equals
setopt extended_glob
setopt glob_dots
setopt magic_equal_subst
setopt mark_dirs
unsetopt case_glob

# History
setopt append_history
setopt bang_hist
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_functions
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
setopt inc_append_history
setopt share_history
unsetopt hist_beep

# Input/Output
setopt correct
setopt correct_all
setopt ignore_eof
setopt interactive_comments
setopt no_clobber
setopt no_flow_control
setopt path_dirs
setopt print_eight_bit
setopt rm_star_wait

# Job Control
setopt auto_resume
setopt long_list_jobs
setopt notify

# Scripts and Functions
# Perform implicit tees or cats when multiple redirections are attempted.
# Examples:
#     ~$ < file1                        # cat
#     ~$ < file1 < file2                # cat 2 files
#     ~$ < file1 > file3                # copy file1 to file3
#     ~$ < file1 > file3 | cat          # Copy and put stdout
#     ~$ cat file1 > file3 > /dev/stdin # tee
setopt multios

# Zle
unsetopt beep


# Aliases
# Neovim
alias vi='nvim'
alias vim='nvim'

# ls -> eza
alias ls='eza'
alias ll='eza -lF --git'
alias la='eza -aF'
alias lla='eza -alF --git'
alias tree='eza -T --git-ignore'

# cat -> bat
alias cat='bat --theme=Dracula'

# grep -> ripgrep
alias grep='rg --color=auto'

# du -> dust
alias du='dust'

alias mv='mv -i'
alias rm='rm -i'
alias du='du -h'
alias cp="${ZSH_VERSION:+nocorrect} cp -i"
alias mkdir="${ZSH_VERSION:+nocorrect} mkdir"
alias sudo="${ZSH_VERSION:+nocorrect} sudo"

# Clipboard
# Linux
if [ $(uname) = 'Linux' ]; then
  alias pbcopy='xclip -selection c'
  alias pbpaste='xclip -selection c -o'
fi
# WSL2
if [[ $(uname -r) == *microsoft* ]]; then
  alias pbcopy='clip.exe'
  alias pbpaste='powershell.exe -Command Get-Clipboard'
fi

# ghq
function ghq-cd() {
  local repository=$(ghq list | fzf +m)
  [[ -n $repository ]] && cd $(ghq root)/$repository
}

alias gl='ghq-cd'

# Global aliases
alias -g G='| rg'
alias -g L='| less'
alias -g X='| xargs'
alias -g N='| >/dev/null 2>&1'
alias -g N1='| >/dev/null'
alias -g N2='| 2>/dev/null'

(( $+galiases[H] )) || alias -g H='| head'
(( $+galiases[T] )) || alias -g T='| tail'

alias -g CP='| pbcopy'
alias -g CC='tee /dev/tty | pbcopy'


# Keybind
# Vim-like key bind as default
bindkey -v

# Add Emacs-like keybind
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
bindkey -M viins '^P' up-line-or-history
bindkey -M viins '^N' down-line-or-history
bindkey -M viins '^D' delete-char-or-list
bindkey -M vicmd '^A' beginning-of-line
bindkey -M vicmd '^E' end-of-line
bindkey -M vicmd '^K' kill-line
bindkey -M vicmd '^P' up-line-or-history
bindkey -M vicmd '^N' down-line-or-history
bindkey -M vicmd '^Y' yank
bindkey -M vicmd '^W' backward-kill-word
bindkey -M vicmd '^U' backward-kill-line

# Surround.vim
autoload -Uz is-at-least
if is-at-least 5.0.8; then
  autoload -Uz surround
  zle -N delete-surround surround
  zle -N change-surround surround
  zle -N add-surround surround
  bindkey -a cs change-surround
  bindkey -a ds delete-surround
  bindkey -a ys add-surround
  bindkey -M visual S add-surround
fi

# Insert a last word
autoload -Uz smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
zstyle :insert-last-word match '*([^[:space:]][[:alpha:]/\\]|[[:alpha:]/\\][^[:space:]])*'


# Completions
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


# Installed programs
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"

volta completions -f --quiet -o"${ZDOTDIR}/completions/_volta" zsh
eval "$(deno completions zsh)"
source "${BUN_INSTALL}/_bun"

eval "$(rye self completion --shell zsh)"
poetry completions zsh >! "${ZDOTDIR}/completions/_poetry"
eval "$(pyenv init -)"

rustup completions zsh >! "${ZDOTDIR}/completions/_rustup"
rustup completions zsh cargo >! "${ZDOTDIR}/completions/_cargo"

eval "$(aws-vault --completion-script-zsh)"

autoload bashcompinit && bashcompinit
complete -C "$(command -v aws_completer)" aws

# Google Cloud SDK
[[ -f $HOME/google-cloud-sdk/path.zsh.inc ]] && source $HOME/google-cloud-sdk/path.zsh.inc
[[ -f $HOME/google-cloud-sdk/completion.zsh.inc ]] && source $HOME/google-cloud-sdk/completion.zsh.inc

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# NOTE: Take a profile if 'zprof' is loaded
if (which zprof > /dev/null); then
  zprof | less
fi
