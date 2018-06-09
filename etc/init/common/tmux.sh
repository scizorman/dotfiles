#!/bin/sh
# Stop script if errors occure.
trap 'echo Error: $0:$LINENO stopped; exit 1' HUP INT QUIT TERM
set -eu

# Get utilities
. "$DOTPATH"/etc/vital.sh

# Install Tmux
if ! has "tmux"; then
    case "$(get_os)" in
        osx)
            if has "brew"; then
                log_echo "Install Tmux with Homebrew."
                brew install tmux
            else
                log_fail "Error: Homebrew is required."
                exit 1
            fi
            ;;

        linux)
            case "$(get_distribution)" in
                redhat)
                    if has "yum"; then
                        log_echo "Install packages required for Tmux with Yellowdog Updater Modified (YUM)."
                        sudo yum -y install ncuress-devel
                    else
                        log_fail "Error: YUM is required."
                        exit 1
                    fi
                    ;;

                ubuntu)
                    if has "apt"; then
                        log_echo "Install packages required for Tmux with Advanced Packaging Tool (APT)."
                        sudo apt -y install build-essential automake libevent-dev ncurses-dev
                    else
                        log_fail "Error: APT is required."
                        exit 1
                    fi
                    ;;

                *)
                    log_fail "Error: This script is only supported OSX and Ubuntu."
                    exit 1
                    ;;
            esac

            if [ -e $HOME/src ]; then
                mkdir -p $HOME/src
            fi

            if has "git"; then
                log_echo "Install Tmux."
                git clone https://github.com/tmux/tmux.git $HOME/src/tmux
                cd $HOME/src/tmux && sh autogen.sh && ./configure && make
                cp $HOME/src/tmux/tmux /usr/local/bin
            else
                log_fail "'git' is required."
                exit 1
            fi
            ;;

        *)
            log_fail "Error: This script is only supported OSX and Linux."
            exit 1
            ;;
    esac
fi

log_pass "Tmux: Installed successfully."
