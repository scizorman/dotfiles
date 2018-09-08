#
# Changing Directoris
#
# If a command is issued that can’t be executed as a normal command, and the
# command is the name of a directory, perform the cd command to that directory.
# This option is only applicable if the option SHIN_STDIN is set, i.e. if
# commands are being read from standard input. The option is designed for
# interactive use; it is recommended that cd be used explicitly in scripts to
# avoid ambiguity.
# setopt auto_cd

# Make cd push the old directory onto the directory stack.
setopt auto_pushd

# Don’t push multiple copies of the same directory onto the directory stack.
setopt pushd_ignore_dups

# Have pushd with no arguments act like ‘pushd $HOME’.
setopt pushd_to_home


# 
# Completion
#
# If unset, key functions that list completions try to return to the last to
# the last prompt if given no numeric argument.
setopt always_last_prompt

# If a completion is performed with the cursor within a word, and a full
# completion is inserted, the cursor is moved to the end of the word. That is,
# the cursor is moved to the end of the word if either a single match is
# inserted or menu completion is performed.
setopt always_to_end

# Automatically list choices on an ambiguous completion.
setopt auto_list

# Automatically use menu completion after the second consecutive request for
# completion, for example by pressing the tab key repeatedly.
# Note: This option is overridden by MENU_COMPLETE.
setopt auto_menu

# If a parameter name was completed and a following character (normally a
# space) automatically inserted, and the next character typed is one of those
# that have to come directly after the name (like ‘}’, ‘:’, etc.), the
# automatically added character is deleted, so that the character typed comes
# immediately after the parameter name. Completion in a brace expansion is
# affected similarly: the added character is a ‘,’, which will be removed if
# ‘}’ is typed next.
setopt auto_param_keys

# If a parameter is completed whose content is the name of a directory, then
# add a trailing slash instead of a space.
setopt auto_param_slash

# When the last character resulting from a completion is a slash and the next
# character typed is a word delimiter, a slash, or a character that ends a
# command (such as a semicolon or an ampersand), remove the slash. 
setopt auto_remove_slash

# If unset, the cursor is set to the end of the word if completion is started.
# Otherwise it stays there and completion is done from both ends.
setopt complete_in_word

# Beep on an ambiguous completion. More accurately, this forces the completion
# widgets to return status 1 on an ambiguous completion, which causes the shell
# to beep if the option BEEP is also set; this may be modified if completion is
# called from a user-defined widget.
setopt no_list_beep # Unset

# When listing files that are possible completions, show the type of each file
# with a trailing identifying mark.
setopt list_types

# On an ambiguous completion, instead of listing possibilities or beeping,
# insert the first match immediately. Then when completion is requested again,
# remove the first match and insert the second match, etc. When there are no
# more matches, go back to the first one again. reverse-menu-complete may be
# used to loop through the list in the other direction.
# Note: This option overrides AUTO_MENU.
setopt no_menu_complete # Unset


# 
# Expansion and Globbing
#
# Expand expressions in braces which would not otherwise undergo brace
# expansion to a lexically ordered list of all the characters.
setopt brace_ccl

# Make globbing (filename generation) sensitive to case. Note that other uses
# of patterns are always sensitive to case. If the option is unset, the
# presence of any character which is special to filename generation will cause
# case-insensitive matching. For example, cvs(/) can match the directory CVS
# owing to the presence of the globbing flag (unless the option
# BARE_GLOB_QUAL is unset).
setopt no_case_glob # Unset

# If a word begins with an unquoted ‘=’ and the EQUALS option is set, the
# remainder of the word is taken as the name of a command. If a command exists
# by that name, the word is replaced by the full pathname of the command.
setopt equals

# Treat the ‘#’, ‘~’ and ‘^’ characters as part of patterns for filename
# generation, etc. (An initial unquoted ‘~’ always produces named directory
# expansion.)
setopt extended_glob

# Do not require a leading ‘.’ in a filename to be matched explicitly.
setopt glob_dots

# All unquoted arguments of the form ‘anything=expression’ appearing after
# the command name have filename expansion (that is, where expression has
# a leading ‘~’ or ‘=’) performed on expression as if it were a parameter
# assignment. The argument is not otherwise treated specially; it is
# passed to the command as a single argument, and not used as an actual
# parameter assignment. For example, in echo foo=~/bar:~/rod, both
# occurrences of ~ would be replaced. Note that this happens anyway with
# typeset and similar statements.
# This option respects the setting of the KSH_TYPESET option. In other
# words, if both options are in effect, arguments looking like assignments
# will not undergo word splitting.
setopt magic_equal_subst

# Append a trailing ‘/’ to all directory names resulting from filename
# generation (globbing).
setopt mark_dirs


# 
# History
#
# If this is set, zsh sessions will append their history list to the
# history file, rather than replace it. Thus, multiple parallel zsh
# sessions will all have the new entries from their history lists added to
# the history file, in the order that they exit. The file will still be
# periodically re-written to trim it when the number of lines grows 20%
# beyond the value specified by $SAVEHIST (see also the HIST_SAVE_BY_COPY
# option).
setopt append_history

# Perform textual history expansion, csh-style, treating the character ‘!’
# specially.
setopt bang_hist

# Save each command’s beginning timestamp (in seconds since the epoch) and
# the duration (in seconds) to the history file. The format of this
# prefixed data is '<beginning time>:<elapsed seconds>;<command>'.
setopt extended_history

# Beep in ZLE when a widget attempts to access a history entry which isn’t
# there.
setopt no_hist_beep # Unset

# If the internal history needs to be trimmed to add the current command
# line, setting this option will cause the oldest history event that has a
# duplicate to be lost before losing a unique event from the list. You
# should be sure to set the value of HISTSIZE to a larger number than
# SAVEHIST in order to give you some room for the duplicated events,
# otherwise this option will behave just like HIST_IGNORE_ALL_DUPS once
# the history fills up with unique events.
setopt hist_expire_dups_first

# If a new command line being added to the history list duplicates an
# older one, the older command is removed from the list (even if it is not
# the previous event).
setopt hist_ignore_all_dups

# Do not enter command lines into the history list if they are duplicates
# of the previous event.
setopt hist_ignore_dups

# Remove command lines from the history list when the first character on
# the line is a space, or when one of the expanded aliases contains a
# leading space. Only normal aliases (not global or suffix aliases) have
# this behaviour. Note that the command lingers in the internal history
# until the next command is entered before it vanishes, allowing you to
# briefly reuse or edit the line. If you want to make it vanish right away
# without entering another command, type a space and press return.
setopt hist_ignore_space

# Remove function definitions from the history list. Note that the
# function lingers in the internal history until the next command is
# entered before it vanishes, allowing you to briefly reuse or edit the
# definition.
setopt hist_no_functions

# Remove the history (fc -l) command from the history list when invoked.
# Note that the command lingers in the internal history until the next
# command is entered before it vanishes, allowing you to briefly reuse or
# edit the line.
setopt hist_no_store

# Remove superfluous blanks from each command line being added to the
# history list.
setopt hist_reduce_blanks

# When writing out the history file, older commands that duplicate newer
# ones are omitted.
setopt hist_save_no_dups

# Whenever the user enters a line with history expansion, don’t execute
# the line directly; instead, perform history expansion and reload the
# line into the editing buffer.
setopt hist_verify

# This option works like APPEND_HISTORY except that new history lines are
# added to the $HISTFILE incrementally (as soon as they are entered),
# rather than waiting until the shell exits. The file will still be
# periodically re-written to trim it when the number of lines grows 20%
# beyond the value specified by $SAVEHIST (see also the HIST_SAVE_BY_COPY
# option).
setopt inc_append_history

# This option both imports new commands from the history file, and also
# causes your typed commands to be appended to the history file (the
# latter is like specifying INC_APPEND_HISTORY, which should be turned off
# if this option is in effect). The history lines are also output with
# timestamps ala EXTENDED_HISTORY (which makes it easier to find the spot
# where we left off reading the file after it gets re-written).
# By default, history movement commands visit the imported lines as well
# as the local lines, but you can toggle this on and off with the
# set-local-history zle binding. It is also possible to create a zle
# widget that will make some commands ignore imported commands, and some
# include them.
# If you find that you want more control over when commands get imported,
# you may wish to turn SHARE_HISTORY off, INC_APPEND_HISTORY or
# INC_APPEND_HISTORY_TIME (see above) on, and then manually import
# commands whenever you need them using ‘fc -RI’.
setopt share_history


# 
# Initialisation
#
# If this option is unset, the startup files /etc/zprofile, /etc/zshrc,
# /etc/zlogin and /etc/zlogout will not be run. It can be disabled and
# re-enabled at any time, including inside local startup files (.zshrc, etc.).
setopt no_global_rcs # Unset

# 
# Input/Output
#
# Allows ‘>’ redirection to truncate existing files. Otherwise ‘>!’ or
# ‘>|’ must be used to truncate a file.
# If the option is not set, and the option APPEND_CREATE is also not set,
# ‘>>!’ or ‘>>|’ must be used to create a file. If either option is set,
# ‘>>’ may be used.
setopt no_clobber

# Try to correct the spelling of commands. Note that, when the
# HASH_LIST_ALL option is not set or when some directories in the path are
# not readable, this may falsely report spelling errors the first time
# some commands are used.
# The shell variable CORRECT_IGNORE may be set to a pattern to match words
# that will never be offered as corrections.
setopt correct

# Try to correct the spelling of all arguments in a line.
# The shell variable CORRECT_IGNORE_FILE may be set to a pattern to match
# file names that will never be offered as corrections.
setopt correct_all

# If this option is unset, output flow control via start/stop characters
# (usually assigned to ^S/^Q) is disabled in the shell’s editor.
setopt no_flow_control

# Do not exit on end-of-file. Require the use of exit or logout instead.
# However, ten consecutive EOFs will cause the shell to exit anyway, to
# avoid the shell hanging if its tty goes away.
# Also, if this option is set and the Zsh Line Editor is used, widgets
# implemented by shell functions can be bound to EOF (normally Control-D)
# without printing the normal warning message. This works only for normal
# widgets, not for completion widgets.
setopt ignore_eof

# Allow comments even in interactive shells.
setopt interactive_comments

# Perform a path search even on command names with slashes in them. Thus
# if ‘/usr/local/bin’ is in the user’s path, and he or she types
# ‘X11/xinit’, the command ‘/usr/local/bin/X11/xinit’ will be executed
# (assuming it exists). Commands explicitly beginning with ‘/’, ‘./’ or
# ‘../’ are not subject to the path search. This also applies to the ‘.’
# and source builtins.
# Note: Subdirectories of the current directory are always searched for
# executables specified in this form. This takes place before any search
# indicated by this option, and regardless of whether ‘.’ or the current
# directory appear in the command search path.
setopt path_dirs

# Print eight bit characters literally in completion lists, etc. This
# option is not necessary if your system correctly returns the
# printability of eight bit characters.
setopt print_eight_bit

# Print the exit value of programs with non-zero exit status. This is only
# available at the command line in interactive shells.
setopt print_exit_value

# If querying the user before executing ‘rm *’ or ‘rm path/*’, first wait
# ten seconds and ignore anything typed in that time. This avoids the
# problem of reflexively answering ‘yes’ to the query when one didn’t
# really mean it. The wait and query can always be avoided by expanding
# the ‘*’ in ZLE (with tab).
setopt rm_star_wait


# 
# Job Control
#
# Treat single word simple commands without redirection as candidates for
# resumption of an existing job.
setopt auto_resume

# Print job notifications in the long format by default.
setopt long_list_jobs

# Report the status of background jobs immediately, rather than waiting
# until just before printing a prompt.
setopt notify


#
# Prompt
#
# Print a carriage return just before printing a prompt in the line
# editor. This is on by default as multi-line editing is only possible if
# the editor knows where the start of the line appears.
setopt no_prompt_cr # Unset


# 
# Scripts and Functions
#
# Perform implicit tees or cats when multiple redirections are attempted.
# Examples:
#     ~$ < file1                        # cat
#     ~$ < file1 < file2                # cat 2 files
#     ~$ < file1 > file3                # copy file1 to file3
#     ~$ < file1 > file3 | cat          # Copy and put stdout
#     ~$ cat file1 > file3 > /dev/stdin # tee
setopt multios


# 
# Shell Emulation
#
# Causes field splitting to be performed on unquoted parameter expansions.
# Note: This option has nothing to do with word splitting.
setopt sh_word_split


# 
# Shell State
#


#
# Zle
#
# Beep on error in ZLE.
setopt no_beep # Unset
