bindkey -M viins \
  '^F' forward-char \
  '^B' backward-char \
  '^A' beginning-of-line \
  '^E' end-of-line \
  '^K' kill-line \
  '^Y' yank \
  '^W' backward-kill-word \
  '^U' backward-kill-line \
  '^H' backward-delete-char \
  '^?' backward-delete-char \
  '^G' send-break \
  '^P' up-line-or-history \
  '^N' down-line-or-history \
  '^D' delete-char-or-list
bindkey -M vicmd \
  '^A' beginning-of-line \
  '^E' end-of-line \
  '^K' kill-line \
  '^P' up-line-or-history \
  '^N' down-line-or-history \
  '^Y' yank \
  '^W' backward-kill-word \
  '^U' backward-kill-line

autoload -Uz is-at-least
if is-at-least 5.0.8; then
  autoload -Uz surround
  zle -N delete-surround surround
  zle -N change-surround surround
  zle -N add-surround surround
  bindkey -a \
    cs change-surround \
    ds delete-surround \
    ys add-surround
  bindkey -M visual S add-surround
fi
