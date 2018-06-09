#!/bin/sh
# Stop script if errors occure.
trap 'echo Error: $0:$LINENO stopped; exit 1' HUP INT QUIT TERM
set -eu

# Get utilities
. "$DOTPATH"/etc/vital.sh

# Install Git
if ! has "git"; then
    case "$(get_os)" in
        osx)
            if has "brew"; then
                log_echo "Install Git with Homebrew."
                brew install git
            else
                log_fail "Error: Homebrew is required."
                exit 1
            fi
            ;;

        linux)
            case "$(get_distribution)" in
                redhat)
                    if has "yum"; then
                        log_echo "Install Git with Yellowdog Updater Modified (YUM)."
                        sudo yum -y install git
                    else
                        log_fail "Error: YUM is required."
                        exit 1
                    fi
                    ;;

                ubuntu)
                    if has "apt"; then
                        log_echo "Install Git with Advanced Packaging Tool (APT)."
                        sudo apt -y install git
                    else
                        log_fail "Error: APT is required."
                        exit 1
                    fi
                    ;;

                *)
                    log_fail "Error: YUM or APT is required."
                    exit 1
                    ;;
            esac
            ;;

        *)
            log_fail "Error: This script is only supported OSX and Linux."
            exit 1
            ;;
    esac
fi

log_pass "Git: Installed successfully."
