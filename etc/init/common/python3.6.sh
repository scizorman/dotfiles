#!bin/sh
# Stop script if errors occure.
trap 'echo Error: $0:$LINENO stopped; exit 1' HUP INT QUIT TERM
set -eu

# Get utilities
. "$DOTPATH"/etc/vital.sh

# Install 'Python' (The latest version)
if ! has "python3.6"; then
    case "$(get_os)" in
        osx)
            if has "brew"; then
                log_echo "Install python (the latest version) with Homebrew."
                brew install python3
            else
                log_fail "Error: Homebrew is required."
                exit 1
            fi
            ;;

        linux)
            if is_redhat || is_ubuntu; then
                if is_redhat; then
                    if has "yum"; then
                        log_echo "Install python (the latest version) with Yellowdog Updater Modified (YUM)."
                        sudo yum -y install https://centos7.iuscommunity.org/ius-release.rpm
                        sudo yum -y install python36u.x86_64 python36u-libs.x86_64 python36u-devel.x86_64 python36u-pip.noarch
                    else
                        log_fail "Error: YUM is required."
                        exit 1
                    fi

                elif is_ubuntu; then
                    if has "apt"; then
                        log_echo "Install python (the latest version) with Advanced Packaging Tool (APT)."
                        sudo add-apt-repository ppa:jonathonf/python3.6
                        sudo apt update
                        sudo apt install python3.6 python3.6-dev
                        curl -kL https://bootstrap.pypa.io/get-pip.py | python3.6
                    else
                        log_fail "Error: APT is required."
                        exit 1
                    fi
                fi

                # Create the symlink '/usr/bin/env python3.6 => /usr/bin/env python3'
                if has "python3.6"; then
                    PYTHON_PATH=`which python3.6`
                    ln -s $PYTHON_PATH ${PYTHON_PATH%%.*}
                fi

                # Create the symlink '/usr/bin/env pip3.6 => /usr/bin/env pip3'
                if has "pip3.6"; then
                    PIP_PATH=`which pip3.6`
                    ln -s $PIP_PATH ${PIP_PATH%%.*}
                fi

            else
                log_fail "Error: This script is only supported CentOS and Ubuntu."
                exit 1
            fi
            ;;

        *)
            log_fail "Error: This script only supported OSX and Linux."
            exit 1
            ;;
    esac
fi

log_pass "python3.6: Installed successfully."
