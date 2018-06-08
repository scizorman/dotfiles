#!/bin/sh
# Stop script if errors occure.
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Get utilities
. "$DOTPATH"/etc/vital.sh

# Install 'tmux'
if ! has "tmux"; then
    case "$(get_os)" in
        osx)
            if has "brew"; then
                log_echo "Install tmux with Homebrew."
                brew install tmux
            elif "port"; then
                log_echo "Install tmux with MacPorts"
                sudo port install tmux
            else
                log_fail "Error: Homebrew or MacPorts is required."
                exit 1
            fi
            ;;

        linux)
            if has "yum" || has "apt"; then
                if has "yum"; then
                    log_echo "Install tmux with Yellowdog Updater Modified (YUM)."
                    sudo yum -y install ncuress-devel
                elif has "apt"; then
                    log_echo "Install tmux with Advanced Packagint Tool (APT)."
                    sudo apt install -y build-essential automake libevent-dev ncurses-dev
                fi

                if [ -e $HOME/src ]; then
                    mkdir -p $HOME/src
                fi

                if ! has "git"; then
                    log_info "'git' is required."
                    . "$DOTPATH"/etc/init/"$(get_os)"/git.sh
                fi

                git clone git@github.com:tmux/tmux.git $HOME/src/tmux

                cd $HOME/src/tmux && sh autogen.sh && ./configure && make
                cp $HOME/src/tmux/tmux /usr/local/bin
            else
                log_fail "Error: YUM or APT is required."
                exit 1
            fi
            ;;

        *)
            log_fail "Error: This script is only supported OSX and Linux."
            exit 1
            ;;
    esac
fi

log_pass "tmux: Installed successfully."
