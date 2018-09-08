{
  local f
  for f in ./*secret*.zsh(N-.); do
    source "$f"
  done
}
