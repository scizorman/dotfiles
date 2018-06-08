#!/bin/sh
# Stop script if errors occure.
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Get utilities
. "$DOTPATH"/etc/vital.sh

# Install 'git'
if ! has "git"; then
    case "$(get_os)" in
        osx)
            if has "brew"; then
                log_echo "Install git with Homebrew."
                brew install git
            elif "port"; then
                log_echo "Install git with MacPorts"
                sudo port install git
            else
                log_fail "Error: Homebrew or MacPorts is required."
                exit 1
            fi
            ;;

        linux)
            if has "yum"; then
                log_echo "Install git with Yellowdog Updater Modified (YUM)."
                sudo yum -y install git
            elif has "apt"; then
                log_echo "Install git with Advanced Packagint Tool (APT)."
                sudo apt -y install git
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

log_pass "git: Installed successfully."
