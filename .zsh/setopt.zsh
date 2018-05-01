# pushd
setopt pushd_ignore_dups
setopt pushd_to_home

# Correct
setopt correct
setopt correct_all

# Prohibit overwrite by redirection (> & >>) (User >! add >>! to bypass.)
setopt no_clobber

# Deploy {a-c} -> a b c
setopt brace_ccl

# Enable 8bit
setopt print_eight_bit

# sh_word_split
setopt sh_word_split

# Case of multi redirection and pipe,
# use 'tee' and 'cat', if needed
# ~$ < file1                           # cat
# ~$ < file1 < file2                   # cat 2files
# ~$ < file1 > file3                   # copy file1 to file3
# ~$ < file1 > file3 | cat             # Copy and put stdout
# ~$ cat file1 > file3 > /dev/stdin    # tee
setopt multios

# Automatically delete slaxh complemented by supplemented by inserting a space.
setopt auto_remove_slash

# No Beep
setopt no_beep
setopt no_list_beep
setopt no_hist_beep

# Expand '=command' as path of command
setopt equals

# Don't use Ctrl+S or Ctrl+q as flow control
setopt no_flow_control

# Look for a sub-directory in $PATH when the slash is included in the command
setopt path_dirs

# Show exit status if it's except zero.
setopt print_exit_value

# Confirm when executing 'rm *'
setopt rm_star_wait

# Let me know immediately when terminating job
setopt notify

# Show process ID
setopt long_list_jobs

# Resume when executing the same name command as suspended process name
setopt auto_resume

# Disable Ctrl-d (Use 'exit', 'logout')
setopt ignore_eof

# Ignore case when glob
setopt no_case_glob

# Use '*, ~, ^' as regular expression
# Match without pattern
# ex. > rm *~398
# remove * without a file "398". For test, use "echo *~398"
setopt extended_glob

# If the path is directory, add '/' to path tail when generating path by glob
setopt mark_dirs

# Automaticall escape URO when copy and paste
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Prevent overwrite prompt from output without cr
setopt no_prompt_cr

# History
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_expire_dups_first
setopt share_history
setopt hist_reduce_blanks
setopt inc_append_history
setopt hist_no_store
setopt hist_no_functions
setopt extended_history
setopt hist_ignore_space
setopt append_history
setopt hist_verify
setopt bang_hist

# etc.
setopt always_last_prompt
setopt auto_cd
setopt auto_menu
setopt auto_param_keys
setopt auto_param_slash
setopt auto_pushd
setopt complete_in_word
setopt globdots
setopt interactive_comments
setopt list_types
setopt magic_equal_subst
