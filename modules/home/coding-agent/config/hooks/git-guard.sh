#!/bin/sh
set -eu

readonly KEBAB_CASE='^[a-z0-9]+(-[a-z0-9]+)*$'

deny() {
  jq -n --arg reason "$1" '{
    hookSpecificOutput: {
      hookEventName: "PreToolUse",
      permissionDecision: "deny",
      permissionDecisionReason: $reason
    }
  }'
  exit 0
}

# Flags are matched as plain substrings of the raw command, quotes and heredocs
# included: recognizing shell syntax here would require a real parser, and a
# rare false positive on text mentioning a flag is cheaper than missing one.
check_dangerous_flags() {
  case "$1" in
  *git*--no-verify* | *git*--no-gpg-sign*)
    deny 'Bypassing hooks or signing is not allowed; run without the flag.'
    ;;
  esac
  case "$1" in
  *git*push*--force*)
    deny 'Force push is not allowed.'
    ;;
  esac
  case "$1" in
  *git*commit*--amend*)
    deny 'Rewriting history is not allowed.'
    ;;
  esac
}

new_branch_name() {
  printf '%s\n' "$1" |
    grep -oE '(switch -c|checkout -b)[[:space:]]+[^[:space:];&|]+' |
    head -n 1 |
    awk '{ print $NF }' |
    sed "s/[\"']//g"
}

check_branch_name() {
  branch=$(new_branch_name "$1")
  [ -n "$branch" ] || return 0
  printf '%s\n' "$branch" | grep -Eq "$KEBAB_CASE" ||
    deny "Branch name \"$branch\" is not kebab-case; use add-export-feature style, not feat/xxx."
}

main() {
  cmd=$(jq -r '.tool_input.command // empty')
  [ -n "$cmd" ] || return 0
  check_dangerous_flags "$cmd"
  check_branch_name "$cmd"
}

main
