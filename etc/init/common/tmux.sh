#!/bin/sh
# Stop script if errors occure.
trap 'echo Error: $0:$LINENO stopped; exit 1' HUP INT QUIT TERM
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
            else
                log_fail "Error: Homebrew is required."
                exit 1
            fi
            ;;

        linux)
            if is_redhat || is_ubuntu; then
                if is_redhat; then
                    if has "yum"; then
                        log_echo "Install tmux with Yellowdog Updater Modified (YUM)."
                        sudo yum -y install ncuress-devel
                    else
                        log_fail "Error: YUM is required."
                        exit 1
                    fi

                elif is_ubuntu; then
                    if has "apt"; then
                        log_echo "Install tmux with Advanced Packaging Tool (APT)."
                        sudo apt install -y build-essential automake libevent-dev ncurses-dev
                    else
                        log_fail "Error: APT is required."
                        exit 1
                    fi
                fi

                if [ -e $HOME/src ]; then
                    mddir -p $HOME/src
                fi

                if ! has "git"; then
                    log_fail "'git' is required."
                    exit 1
                else
                    git clone git@github.com:tmux/tmux.git $HOME/src/tmux
                    cd $HOME/src/tmux && sh autogen.sh && ./configure && make
                    cp $HOME/src/tmux/tmux /usr/local/bin
                fi
                
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
