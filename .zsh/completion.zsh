autoload -Uz compinit; compinit


zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''

zstyle ':completion:*default' menu select=2

zstyle ':completion:*default' list-colors ""
zstyle ':completion:*' list-colors $LSCOLORS

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*'

zstyle ':completion:*' completer \
    _oldlist _complete _match _history _ignored _approximate _prefix

zstyle ':completion:*' use-cache yes

zstyle ':completion:*' verbose yes

zstyle ':completion:sudo:*' environ PATH="$SUDO_PATH:$PATH"
