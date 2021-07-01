#!/usr/bin/env zsh
umask 022
limit coredumpsize 0


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


if [ $(uname) = 'Linux' ]; then
  # Homebrew
  export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
  export MANPATH=/home/linuxbrew/.linuxbrew/share/man:$MANPATH
  export INFOPATH=/home/linuxbrew/.linuxbrew/share/info:$INFOPATH
  export LD_LIBRARY_PATH=/home/linuxbrew/.linuxbrew/lib:$LD_LIBRARY_PATH

  # Go
  export PATH=$HOME/sdk/go1.16.5/bin:$PATH

  # PostgreSQL Client
  export PATH=/home/linuxbrew/.linuxbrew/opt/libpq/bin:$PATH

  # MySQL Client
  export PATH=/home/linuxbrew/.linuxbrew/opt/mysql-client/bin:$PATH
else
  # Go
  export PATH=/usr/local/go/bin:$PATH

  # PostgreSQL Client
  export PATH=/usr/local/opt/libpq/bin:$PATH

  # MySQL Client
  export PATH=/usr/local/opt/mysql-client/bin:$PATH
fi

# SDKMAN
[[ -s $HOME/.sdkman/bin/sdkman-init.sh ]] && source $HOME/.sdkman/bin/sdkman-init.sh

# Go
export GOPATH=${GOPATH:-$HOME/go}
export PATH="$GOPATH/bin:$PATH"

# Node
# NVM
export NVM_DIR=$HOME/.nvm
[ -s "$(brew --prefix nvm)/nvm.sh" ] && . "$(brew --prefix nvm)/nvm.sh"
[ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && . "$(brew --prefix nvm)/etc/bash_completion.d/nvm"

# Python
# pyenv
eval "$(pyenv init --path --no-rehash)"

# Poetry
export PATH=$HOME/.poetry/bin:$PATH
export POETRY_VIRTUALENVS_IN_PROJECT=true

# Rust
export PATH=$HOME/.cargo/bin:$PATH

# Flutter
export PATH=$HOME/flutter/bin:$PATH

# Zinit
source $ZDOTDIR/.zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit for \
  light-mode atload'_zsh_autosuggest_start' \
             zsh-users/zsh-autosuggestions \
  light-mode atpull'zinit creinstall -q .' atload'zicompinit; zicdreplay' blockf \
             zsh-users/zsh-completions \
  light-mode zdharma/fast-syntax-highlighting \
             zdharma/history-search-multi-word \
  light-mode wait'!1' lucid \
             b4b4r07/enhancd

zinit ice as'completion'
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

zinit ice as'completion'
zinit snippet https://github.com/docker/compose/blob/master/contrib/completion/zsh/_docker-compose

# Pure (https://github.com/sindresorhus/pure)
PUREDIR=$ZDOTDIR/pure
if [ ! -d $PUREDIR ]; then
  git clone https://github.com/sindresorhus/pure.git $PUREDIR
fi
fpath+=$PUREDIR
autoload -Uz promptinit; promptinit
prompt pure

# AWS CLI
autoload bashcompinit && bashcompinit
complete -C '/usr/local/bin/aws_completer' aws

# Google Cloud SDK
[[ -f $HOME/google-cloud-sdk/path.zsh.inc ]] && source $HOME/google-cloud-sdk/path.zsh.inc
[[ -f $HOME/google-cloud-sdk/completion.zsh.inc ]] && source $HOME/google-cloud-sdk/completion.zsh.inc


# NOTE: Take a profile if 'zprof' is loaded
if (which zprof > /dev/null); then
  zprof | less
fi
