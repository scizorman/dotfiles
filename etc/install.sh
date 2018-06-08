#!/bin/sh
# Set DOTPATH as default variable.
if [ -z "${DOTPATH:-}" ]; then
    DOTPATH=$HOME/.dotfiles
    export DOTPATH
fi

DOTFILE_GITHUB="https://github.com/Scizor-master/dotfiles.git"
export DOTFILE_GITHUB

# Source utilities
source $DOTPATH/etc/vital.sh


# Download
dotfiles_download(){
    if [ -d "$DOTPATH" ]; then
        log_fail "$DOTPATH: Already exists"
        exit 1
    fi

    e_newline
    e_header "Downloading dotfiles..."

    if is_debug; then
        :
    else
        if is_exists "git"; then
            git clone --recursive "$DOTFILE_GITHUB" "$DOTPATH"
        elif is_exists "curl" || is_exists "wget"; then
            local tarball="https://github.com/Scizor-master/dotfiles/archive/master.tar.gz"
            if is_exists "curl"; then
                curl -L "$tarball"
            elif is_exists "wget"; then
                wget -O - "$tarball"
            fi | tar xvz

            if [ ! -d dotfiles-master ]; then
                log_fail "dotfiles-master: Not found"
                exit 1
            fi
            command mv -f dotfiles-master "$DOTPATH"
        else
            log_fail "'curl' or 'wget' are required."
            exit 1
        fi
    fi
    e_newline && e_done "Download"
}

# Deploy
dotfiles_deploy(){
    e_newline
    e_header "Deploying dotfiles..."

    if [ ! -d $DOTPATH ]; then
        log_fail "$DOTPATH: Not found"
        exit 1
    fi

    cd "$DOTPATH"

    if is_debug; then
        :
    else
        make deploy
    fi &&
        e_newline && e_done "Deploy"
}

# Initialize
dotfiles_initialize(){
    if [ "$1" == "init" ]; then
        e_newline
        e_header "Initializing dotfiles..."

        if is_debug; then
            :
        else
            if [ -f Makefile ]; then
                make init
            else
                log_fail "Makefile: Not found"
                exit 1
            fi
        fi && 
            e_newline && e_done "Initialize"
    fi
}

# Install
dotfiles_install(){
    dotfiles_download &&
    dotfiles_deploy &&
    dotfiles_initialize "$@"
}


if echo "$-" | grep -q "i"; then
    VITALIZED=1
    export VITALIZED

    : return
else
    if [ "$0" == "${BASH_SOURCE:-}" ]; then
        exit
    fi

    if [ -n "${BASH_EXECUTION_STRING:-}" ] || [ -p /dev/stdin ]; then
        if [ "${VITALIZED:=0}" == 1 ]; then
            exit
        fi

        dotfiles_install "$@"

        if [ -p /dev/stdin ]; then
            e_warning "Now continue with rebooting your shell."
        else
            e_newline
            e_arrow "Restarting your shell..."
            exec "${SHELL:-/bin/zsh}"
        fi
    fi
fi
