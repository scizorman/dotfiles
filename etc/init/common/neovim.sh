#!/bin/sh
# Stop script if errors occure.
trap 'echo Error: $0:$LINENO stopped; exit 1' HUP INT QUIT TERM
set -eu

# Get utilities
. "$DOTPATH"/etc/init/assets/vital.sh

# Install Neovim
if ! has "nvim"; then
    case "$(get_os)" in
        osx)
            if has "brew"; then
                log_echo "Install Neovim with Homebrew."
                brew install neovim
            else
                log_fail "Error: Homebrew is required."
                exit 1
            fi
            ;;

        linux)
            case "$(get_distribution)" in
                redhat)
                    if has "yum"; then
                        log_echo "Install Neovim with Yellowdog Updater Modified (YUM)."
                        cp "$DOTPATH"/etc/init/assets/Neovim/neovim.repo /etc/yum.repos.d/neovim.repo
                        sudo yum -y install neovim
                    else
                        log_fail "Error: YUM is required."
                        exit 1
                    fi
                    ;;

                ubuntu)
                    if has "apt"; then
                        log_echo "Install Neovim with Advanced Packaging Tool (APT)."
                        sudo apt -y install neovim
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

log_pass "Neovim: Install successfully."


# Install python packages for Neovim
if has "pip"; then
    log_echo "Install packages (Python2.7) for Neovim."
    pip install -r "$DOTPATH"/etc/init/assets/Neovim/nvim_py2_requirements.txt
else
    log_fail "Error: 'pip' (for Python2.7) is required."
    exit 1
fi

if has "pip3"; then
    log_echo "Install packages (Python3.6) for Neovim."
    pip3 install -r "$DOTPATH"/etc/init/assets/Neovim/nvim_py3_requirements.txt
else
    log_fail "Error: 'pip3' (for Python3.6) is required."
    exit 1
fi

log_pass "Packages (Python) for Neovim: Installed successfully."
