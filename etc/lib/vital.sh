#!/bin/bash
# General utilities
is_interactive() {
  if [ "${-/i/}" != "$-" ]; then
    return 0
  fi
  return 1
}

is_bash() {
  [ -n "$BASH_VERSION" ]
}

is_zsh() {
  [ -n "$ZSH_VERSION" ]
}

is_debug() {
  if [ "$DEBUG" = 1 ]; then
    return 0
  else
    return 1
  fi
}

is_exists() {
  command -v "$1" >/dev/null 2>&1
  return $?
}

has() {
  is_exists "$@"
}

die() {
  e_error "$1" 1>&2
  exit "${2:-1}"
}

contains() {
  string="$1"
  substring="$2"
  if [ "${string#*$substring}" != "$string" ]; then
    return 0
  else
    return 1
  fi
}

detect_os() {
  export PLATFORM
  case "$(uname | tr "[:upper:]" "[:lower:]")" in
    *'darwin'*)
      PLATFORM='osx'
      ;;
    *'linux'*)
      PLATFORM='linux'
      ;;
    *'bsd'*)
      PLATFORM='bsd'
      ;;
    *)
      PLATFORM='unknown'
      ;;
  esac
}

is_osx() {
  detect_os
  [[ "$PLATFORM" = 'osx' ]] && return 0 || return 1
}

is_linux() {
  detect_os
  [[ "$PLATFORM" = 'linux' ]] && return 0 || return 1
}

is_bsd() {
  detect_os
  [[ "$PLATFORM" = 'bsd' ]] && return 0 || return 1
}

get_os() {
  local os
  for os in osx linux bsd; do
    if is_$os; then
      echo $os
    fi
  done
}


# Logging
e_newline() {
  printf "\n"
}

e_header() {
  printf "\033[37;1m%s\033[m\n" "$*"
}

e_error() {
  printf "\033[31m%s\033[m\n" "✗ $*" 1>&2 # U+2717
}

e_warning() {
  printf "\033[31m%s\033[m\n" "$*"
}

e_done() {
  printf "\033[37;1m%s\033[m...\033[32mOK\033m\n" "✔ $*" # U+2714
}

e_arrow() {
  printf "\033[37;1m%s\033[m\n" "➔ $*" # U+2794
}

ink() {
  if [ "$#" -ne 2 ]; then
    echo 'Usage: ink <color> <text>'
    echo 'Colors:'
    echo '  black, red, green, yellow, blue, purple, cyan, gray'
    return 1
  else
    case "$1" in
      black)
        local color='0;30m'
        ;;
      red)
        local color='1;31m'
        ;;
      green)
        local color='1;32m'
        ;;
      yellow)
        local color='1;33m'
        ;;
      blue)
        local color='1;34m'
        ;;
      purple)
        local color='1;35m'
        ;;
      cyan)
        local color='1;36m'
        ;;
      gray)
        local color='0;37m'
        ;;
      *)
        echo "The specified color cannot be used."
        return 1
        ;;
    esac

    printf "\033[${color}$2\033[0m"
  fi
}

logging() {
  if [ "$#" -ne 2 ]; then
    echo 'Usage: logging <fmt> <msg>'
    echo 'Formatting options:' echo '  TITLE, ERROR, WARNING, INFO, SUCCESS'
    return 1
  fi

  local color=
  local text="$2"

  case "$1" in
    TITLE)
      color=cyan
      ;;
    INFO)
      color=blue
      ;;
    SUCCESS)
      color=green
      ;;
    WARNING)
      color=yellow
      ;;
    ERROR)
      color=red
      ;;
    *)
      text="$1"
      ;;
  esac

  timestamp() {
    ink gray "["
    ink purple "$(date +%H:%M:%S)"
    ink gray "]"
  }

  timestamp; ink "$color" "$text"; echo
}

log_echo() {
  logging TITLE "$1"
}

log_info() {
  logging INFO "$1"
}

log_pass() {
  logging SUCCESS "$1"
}

log_warning() {
  logging WARNING "$1"
}

log_fail() {
  logging ERROR "$1" 1>&2
}
