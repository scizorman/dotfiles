has(){
    type "${1:?too few arguments}" &> /dev/null
}

# Returns true if current shell is first shell
is_login_shell(){
    [[ $SHLVL == 1 ]]
}

# Returns true if cwd is in git repository
is_git_repo(){
    git rev-parse --is-inside-work-tree &> /dev/null
    return $status
}

# Returns true if GNU screen is running
is_screen_running(){
    [[ -n $STY ]]
}

# Returns true if tmux is running
is_tmux_running(){
    [[ -n $TMUX ]]
}

# Returns true if GNU screen or tmux is running
is_screen_or_tmux_running(){
    is_screen_running || is_tmux_running
}


# Returns true if the current shell is running from command line
shell_has_started_interactively(){
    [[ -n $PS1 ]]
}

# Returns true if the ssh daemon is available
is_ssh_running(){
    [[ -n $SSH_CLIENT ]]
}


# OS
os_detect(){
    export PLATFORM
    case "${(L):-$(uname)}" in
        *'linux'* ) PLATFORM='linux' ;;
        *'darwin'* ) PLATFORM='osx' ;;
        *'bsd'*) PLATFORM='bsd' ;;
        * ) PLATFORM='unknown' ;;
    esac
}

# Returns true if running OS is OSX
is_osx(){
    os_detect
    [[ $PLATFORM == 'osx' ]] && return 0 || return 1
}

# Returns true if running OS is GNU/Linux
is_linux(){
    os_detect
    [[ $PLATFORM == 'linux' ]] && return 0 || return 1
}

# Returns true if running OS is FreeBSD
is_bsd(){
    os_detect
    [[ $PLATFORM == 'bsd' ]] && return 0 || return 1
}

# Returns OS name of the platform that is running
get_os(){
    local os
    for os in osx linux bsd; do
        [[ is_$os ]] && echo $os
    done
}
