zstyle ':completion:*' \
  auto-description '%d' \
  completer _complete _match _approximate \
  format '%F{yellow}-- %d --%f' \
  group-name '' \
  matcher-list 'm:{a-z}={A-Z}' \
  use-cache true \
  verbose yes

zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
zstyle ':completion:*:cd:*' ignored-parents parent pwd

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
