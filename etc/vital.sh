# PLATFORM is the environment variable that retrieves the name of the running
# platform.
_TAB_="$(printf "\t")"
_SPACE_=' '
_BLANK_="${_SPACE_}${_TAB_}"
_IFS_="$IFS"

vitalize(){
    return 0
}

# General utilities
is_interactive(){
    if [ "${-/i/}" != "$-" ]; then
        return 0
    fi
    return 1
}

is_bash(){
    [ -n "$BASH_VERSION" ]
}

is_zsh(){
    [ -n "$ZSH_VERSION" ]
}

is_at_least(){
    if [ -z "$1" ]; then
        return 1
    fi

    # For Zsh
    if is_zsh; then
        autoload -Uz is-at-least
        is-at-least "${1:-}"
        return $?
    fi

    at_least="$(echo $1 | sed -e 's/\.//g')"
    version="$(echo ${BASH_VERSION:-0.0.0} | sed -e 's/^\([0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}\).*/\1/' | sed -e 's/\.//g')"

    # Zero padding
    while [ ${#at_least} -ne 6 ]; do
        at_least="${at_least}0"
    done

    while [ ${#version} -ne 6 ]; do
        version="${version}0"
    done

    # Verbose
    if [ "$at_least" -le "$version" ]; then
        return 0
    else
        return 1
    fi
}

# Returns the lowercase OS name.
ostype(){
    uname | lower
}

# Export the PLATFORM variable as you see fit.
detect_os(){
        export PLATFORM
    case "$(ostype)" in
        *'linux'*)
            PLATFORM='linux'
            ;;
        *'darwin'*)
            PLATFORM='osx'
            ;;
        *'bsd'*)
            PLATFORM='bsd'
            ;;
        *)
            PLATFORM='unknown'
            ;;
    esac
}

# Returns true if running os is Linux.
is_linux(){
    detect_os
    if [[ $PLATFORM == 'linux' ]]; then
        return 0
    else
        return 1
    fi
}

# Returns true if running os is OSX.
is_osx(){
    detect_os
    if [[ $PLATFORM == 'osx' ]]; then
        return 0
    else
        return 1
    fi
}

# Returns true if running os is FreeBSD.
is_bsd(){
    detect_os
    if [[ $PLATFORM == 'bsd' ]]; then
        return 0
    else
        return 1
    fi
}

# Returns OS name of the platform that is running.
get_os(){
    local os
    for os in osx linux bsd; do
        if is_$os; then
            echo $os
        fi
    done
}


e_newline(){
    print "\n"
}

e_header() {
    printf " \033[37;1m%s\033[m\n" "$*"
}

e_error() {
    printf " \033[31m%s\033[m\n" "✖ $*" 1>&2
}

e_warning() {
    printf " \033[31m%s\033[m\n" "$*"
}

e_done() {
    printf " \033[37;1m%s\033[m...\033[32mOK\033[m\n" "✔ $*"
}

e_arrow() {
    printf " \033[37;1m%s\033[m\n" "➜ $*"
}

e_indent() {
    for ((i=0; i<${1:-4}; i++)); do
        echon " "
    done
    if [ -n "$2" ]; then
        echo "$2"
    else
        cat <&0
    fi
}

e_success() {
    printf " \033[37;1m%s\033[m%s...\033[32mOK\033[m\n" "✔ " "$*"
}

e_failure() {
    die "${1:-$FUNCNAME}"
}

ink(){
    if [ "$#" -eq 0 -o "$#" -gt 2 ]; then
        echo "Usage: ink <color> <text>"
        echo "Colors:"
        echo "    black, white, red, green, yellow, blue, purple, cyan, gray"
        return 1
    fi

    local open="\033["
    local close="${open}0m"
    local black="0;30m"
    local red="1;31m"
    local green="1;32m"
    local yellow="1;33m"
    local blue="1;34m"
    local purple="1;35m"
    local cyan="1;36m"
    local gray="0;37m"
    local white="$close"

    local text="$1"
    local color="$close"

    if [ "$#" -eq 2 ]; then
        text="$2"
        case "$1" in
            black | red | green | yellow | blue | purple | cyan | gray | white)
                eval color="\$$1"
                ;;
        esac
    fi

    printf "${open}${color}${text}${close}"
}

logging() {
    if [ "$#" -eq 0 -o "$#" -gt 2 ]; then
        echo "Usage: ink <fmt> <msg>"
        echo "Formatting Options:"
        echo "    TITLE, ERROR, WARN, INFO, SUCCESS"
        return 1
    fi

    local color=
    local text="$2"

    case "$1" in
        TITLE)
            color=blue
            ;;
        ERROR)
            color=red
            ;;
        WARN)
            color=yellow
            ;;
        INFO)
            color=blue
            ;;
        SUCCESS)
            color=green
            ;;
        *)
            text="$1"
    esac

    timestamp() {
        ink gray "["
        ink purple "$(date +%H:%M:%S)"
        ink gray "] "
    }

    timestamp; ink "$color" "$text"; echo
}

log_pass() {
    logging SUCCESS "$1"
}

log_fail() {
    logging ERROR "$1" 1>&2
}

log_warn() {
    logging WARN "$1"
}

log_info() {
    logging INFO "$1"
}

log_echo() {
    logging TITLE "$1"
}

# Returns true if executable $1 exists in $PATH.
is_exists() {
    which "$1" >/dev/null 2>&1
    return $?
}

# Wrapper function.
has(){
    type "${1:?too few arguments}" &>/dev/null
}

# Returns exit code error and echo error message.
die(){
    e_error "$1" 1>&2
    exit "${2:-1}"
}

# Returns true if current shell is first shell.
is_login_shell(){
    [[ $SHLVL == 1 ]]
}

# Returns true if cwd is in git repository
is_git_repo(){
    git rev-parse --is-inside-work-tree &>/dev/null
    return $status
}

# Returns true if GNU screen is running.
is_screen_running(){
    [[ -n $STY ]]
}

# Returns true if tmux is running.
is_tmux_running(){
    [[ -n $TMUX ]]
}

# Returns true if GNU screen or tmux is running.
is_screen_or_tmux_running(){
    is_screen_running || is_tmux_running
}

# Returns true if the current shell is running from command line.
shell_has_started_interactively(){
    [[ -n $PS1 ]]
}

# Returns true if the ssh daemon is available.
is_ssh_running(){
    [[ -n $SSH_CLIENT ]]
}

# Returns true if $DEBUG is set.
is_debug(){
    if [ "$DEBUG" == 1 ]; then
        return 0
    else
        return 1
    fi
}

# Returns true if $1 is int type.
is_number(){
    if [ $# -eq 0 ]; then

        cat <&0
    else
        echo "$1"
    fi | grep -E '^[0-9]+$' >/dev/null 2>&1

    if [ $? -eq 0 ]; then
        return 0
    else
        return 1
    fi
}

# Emulate the '-n' flag functionality with 'echo' for UNIX systems that don't
# have that available.
echon(){
    echo "$*" | tr -d '\n'
}

# Returns a copy of the string with all letters mapped to their lower case.
lower(){
    if [ $# -eq 0 ]; then
        cat <&0
    elif [ $# -eq 1 ]; then
        if [ -f "$1" -a -r "$1" ]; then
            cat "$1"
        else
            echo "$1"
        fi
    else
        return 1
    fi | tr "[:upper:]" "[:lower:]"
}

# Returns a copy of the string with all letters mapped to their upper case.
upper(){
    if [ $# -eq 0 ]; then
        cat <&0
    elif [ $# -eq 1 ]; then
        if [ -f "$1" -a -r "$1" ]; then
            cat "$1"
        else
            echo "$1"
        fi
    else
        return 1
    fi | tr "[:lower:]" "[:upper:]"
}

# Returns true if the specified string contains the specified substring,
# otherwise returns false.
contains(){
    string="$1"
    substring="$2"
    if [ "${string#*substring}" != "$string" ]; then
        return 0
    else
        return 1
    fi
}

# Returns the length of $1.
len(){
    local length
    length="$(echo "$1" | wc -c | sed -e 's/ *//')"
    echo $(( "$length" - 1 ))
}

# Returns true if $1 consists of $_BLANK_.
is_empty(){
    if [ $# -eq 0 ]; then
        cat <&0
    else
        echo "$1"
    fi | grep -E "^{$_BLANK_}*$" >/dev/null 2>&1

    if [ $? -eq 0 ]; then
        return 0
    else
        return 1
    fi
}

# Returns new $PATH trailing $1 in $PATH removed.
path_remove(){
    if [ $# -eq 0 ]; then
        die "too few arguments"
    fi

    local arg path
    path=":$PATH:"

    for arg in "$@"; do
        path="${path//:$arg:/:}"
    done

    path="${path%:}"
    path="${path#:}"

    echo "$path"
}
