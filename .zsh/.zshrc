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


# Zinit
source $ZDOTDIR/.zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit wait lucid light-mode from'gh-r' as'program' for \
  pick'bat*/bat' \
    @sharkdp/bat \
  pick'fd*/fd' \
    @sharkdp/fd \
  mv'exa* -> exa' pick'exa' \
    ogham/exa \
  pick'delta*/delta' \
    dandavison/delta \
  pick'ripgrep*/rg' \
    BurntSushi/ripgrep \
    junegunn/fzf-bin \
  pick'ghq*/ghq' \
    x-motemen/ghq \

zinit wait'!3' lucid light-mode from'gh-r' as'program' for \
  pick'gh*/bin/gh' \
    cli/cli \
  atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' mv'direnv* -> direnv' src'zhook.zsh' \
    direnv/direnv \
  mv'prototool* -> prototool' \
    uber/prototool \
  mv'sops* -> sops' bpick'*darwin' \
    mozilla/sops \
  mv'golangci-lint* -> golangci-lint' pick'golangci-lint*/golangci-lint' \
    golangci/golangci-lint \
  mv'bazelisk* -> bazel' \
    bazelbuild/bazelisk \
  mv'bazel-deps* -> bazel-deps' \
    johnynek/bazel-deps

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
complete -C aws_completer aws

# Google Cloud SDK
[[ -f $HOME/google-cloud-sdk/path.zsh.inc ]] && source $HOME/google-cloud-sdk/path.zsh.inc
[[ -f $HOME/google-cloud-sdk/completion.zsh.inc ]] && source $HOME/google-cloud-sdk/completion.zsh.inc


# NOTE: Take a profile if 'zprof' is loaded
if (which zprof > /dev/null); then
  zprof | less
fi
