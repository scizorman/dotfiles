#!/bin/sh
# Stop script if errors occure.
trap 'echo Error: $0:$LINENO stopped; exit 1' HUP INT QUIT TERM
set -eu

# Get utilities
. "$DOTPATH"/etc/vital.sh

# The script is dependent on python2.7
if ! has "python2.7"; then
    log_fail "Error: python2.7 is reqruied."
    exit 1
fi

# 
if is_osx; then
    if ! has "brew"; then
        log_fail "Error: Homebrew is required."
        exit 1
    fi

    if ! has /usr/local/bin/python2.7; then
        brew install python@2
    fi

elif is_linux; then
    if is_redhat || is_ubuntu; then
        if is_redhat; then
            if has "yum"; then
                log_echo "Install python2.7 with Yellowdog Updater Modified (YUM)."
                sudo yum -y install python2-devel python2-pip
            else
                log_fail "Error: YUM is required."
                exit 1
            fi

        elif is_ubuntu; then
            if has "apt"; then
                log_echo "Install python2.7 with Advanced Packaging Tool (APT)."
                sudo apt -y install python-pip python-dev
            else
                log_fail "Error: APT is required."
                exit 1
            fi
        fi
    fi

else
    log_fail "Error: This script is only supported CentOS and Ubuntu."
    exit 1
fi

log_pass "python2.7: Installed successfully."
