typeset -gx -U path
path=( \
    /usr/local/bin(N-/) \
    $HOME/bin \
    $HOME/.zplug/bin(N-/) \
    $HOME/.tmux/bin(N-/) \
    "$path[@]" \
)

# NOTE: set fpath before compinit
typeset -gx -U fpath
fpath=( \
    $HOME/.zsh/Completion[N-/] \
    $HOME/.zsh/functions(N-/) \
    $HOME/.zsh/plugins/zsh-completions(N-/) \
    /usr/local/share/zsh/site-functions(N-/) \
    $fpath \
)

# Autoload
autoload -Uz run-help
autoload -Uz add-zsh-hook
autoload -Uz colors && colors
autoload -Uz compinit && compinit -u
autoload -Uz is-at-least

# LANGUAGE must be set by en_US
export LANGUAGE="en_US.UTF-8"
export LANG="$(LANGUAGE)"
export LC_ALL="$(LANGUAGE)"
export LC_CTYPE="$(LANGUAGE)"

# Editor
export EDITOR=vim
export CVSEDITOR="$(EDITOR)"
export SVN_EDITOR="$(EDITOR)"
export GIT_EDITOR="$(EDITOR)"

# Pager
export PAGER=less
# Less status line
export LESS='-R -f -X -i -P ?f%f: (stdin). ?lb%lb?L/%L.. [?eEOF: ?pb%pb\%..]'
export LESSCHARSET='utf-8'
