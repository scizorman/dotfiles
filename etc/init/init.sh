#!/bin/sh
export SETUP_DIR

# Stop script if errors occure
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Get utilities
. "$DOTPATH"/etc/vital.sh

if [ -z "$DOTPATH" ]; then
    echo '$DOTPATH not set' >&2
    exit 1
fi

# Ask for the administrator password upfront
sudo -v

# Keep-alive
# Update existing `sudo` time stamp until this script has finnished.
while true; do
    sudo -n true
    sleep 60;
    kill -0 "$$" || exit
done 2>/dev/null &

# Initialize
for f in "$DOTPATH"/etc/init/"$(get_os)"/*.sh; do
    if [ -f "$f" ]; then
        log_info "$(e_arrow "$(basename "$f")")"
        if [ "${DEBUG:-}" != 1 ]; then
            sh $f
        fi
    else
        continue
    fi
done

log_pass "$0: Finish!!" | sed "s $DOTPATH \$DOTPATH g"
