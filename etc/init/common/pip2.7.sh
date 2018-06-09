#!/bin/sh
# Stop script if errors occure.
trap 'echo Error: $0:$LINENO stopped; exit 1' HUP INT QUIT TERM
set -eu

# Get utilities
. "$DOTPATH"/etc/vital.sh

# Install 'pip2.7'
if ! has "pip"; then
    case "$(get_os)" in
        osx)
            if has "brew"; then
                log_echo "Install Python2.7 with Homebrew."
                log_echo "Python2.7 installed by Homebrew has 'pip'."
                brew install python@2
            else
                log_fail "Error: Homebrew is required."
                exit 1
            fi
            ;;

        linux)
            if ! has "python2.7"; then
                log_fail "Error: Python2.7 is required."
                exit 1
            fi

            case "$(get_distribution)" in
                redhat)
                    if has "yum"; then
                        log_echo "Install 'pip' with Yellowdog Updater Modified (YUM)."
                        sudo yum -y install python2-devel python2-pip
                    else
                        log_fail "Error: YUM is required."
                        exit 1
                    fi
                    ;;

                ubuntu)
                    if has "apt"; then
                        log_echo "Install 'pip' with Advanced Packaging Tool (APT)."
                        sudo apt -y install python-pip python-dev
                    else
                        log_fail "Error: APT is required."
                        exit 1
                    fi
                    ;;

                *)
                    log_fail "Error: This script is only supported CentOS and Ubuntu."
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

log_pass "pip: Installed successfully."
