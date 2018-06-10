#!bin/sh
# Stop script if errors occure.
trap 'echo Error: $0:$LINENO stopped; exit 1' HUP INT QUIT TERM
set -eu

# Get utilities
. "$DOTPATH"/etc/init/assets/vital.sh

# Install 'Python3.6'
if ! has "python3.6" || ! has "pip3.6"; then
    case "$(get_os)" in
        osx)
            if has "brew"; then
                log_echo "Install Python3.6 and 'pip3.6' with Homebrew."
                brew install python3
            else
                log_fail "Error: Homebrew is required."
                exit 1
            fi
            ;;

        linux)
            case "$(get_distribution)" in
                redhat)
                    if has "yum"; then
                        log_echo "Install Python3.6 and pip3.6 with Yellowdog Updater Modified (YUM)."
                        sudo yum -y install https://centos7.iuscommunity.org/ius-release.rpm
                        sudo yum -y install python36u.x86_64 python36u-libs.x86_64 python36u-devel.x86_64 python36u-pip.noarch

                        log_echo "Create the symlink 'python3.6 -> python3'."
                        PYTHON_PATH=`which python3.6`
                        ln -sfnv $PYTHON_PATH ${PYTHON_PATH%%.*}
                    else
                        log_fail "Error: YUM is required."
                        exit 1
                    fi
                    ;;

                ubuntu)
                    if has "apt"; then
                        log_echo "Install Python3.6 and pip3.6 with Advanced Packaging Tool (APT)."
                        sudo apt -y install python3.6 python3.6-dev python3.6-venv python3-pip
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

            if has "pip3.6"; then
                log_echo "Create the symlink 'pip3.6 -> pip3'."
                PIP_PATH=`which pip3.6`
                ln -sfnv $PIP_PATH ${PIP_PATH%%.*}
            fi
            ;;

        *)
            log_fail "Error: This script only supported OSX and Linux."
            exit 1
            ;;
    esac
fi

log_pass "Python3.6 and 'pip3.6': Installed successfully."
