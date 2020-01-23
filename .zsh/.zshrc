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
# NOTE: In the future, enable automatic determination (bpick)
source "$ZDOTDIR/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=zinit

zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

zinit ice wait"!0" blockf
zinit light zsh-users/zsh-completions

zinit ice wait"!0" atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

zinit ice wait"!0" atinit'zpcompinit; zpcdreplay'
zinit light zdharma/fast-syntax-highlighting

zinit ice wait"!0"
zinit light b4b4r07/enhancd

zinit ice wait"!0" from"gh-r" as"program" mv"bazel* -> bazel" pick"bazel"
zinit light bazelbuild/bazel

zinit ice wait"!0" from"gh-r" as"program" mv"mdr* -> mdr" pick"mdr"
zinit light MichaelMure/mdr
