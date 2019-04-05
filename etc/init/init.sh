#!/bin/bash
export DOTFILES_PATH="$(cd $(dirname $(readlink $0 || echo $0))/../../; pwd)"

# Stop script if errors occure
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Get utilities
if [ -z "$DOTFILES_PATH" ]; then
  echo "$DOTFILES_PATH not set" >&2
  exit 1
fi

. "$DOTFILES_PATH/etc/lib/vital.sh"

# Ask for the administrator password upfront
sudo -v

# Keep-alive
# Update existing `sudo` time stamp until this script has finnished
while true; do
  sudo -n true
  sleep 60;
  kill -0 "$$" || exit
done 2>/dev/null &

# Initialize
log_echo "start initialize"
e_newline

INIT_DIR="$DOTFILES_PATH"/etc/init/"$(get_os)"

if [ -d "$INIT_DIR" ]; then
  for i in "$INIT_DIR"/*.sh; do
    if [ -f "$i" ]; then
      log_info "$(e_arrow "$(basename "$i")")"
      if [ "${DEBUG:-}" != 1 ]; then
        bash "$i"
      fi
    else
      continue
    fi
  done
else
  log_fail "error: Not found '$INIT_DIR'"
  exit 1
fi

e_newline
log_pass "finished initialize successfully!"
