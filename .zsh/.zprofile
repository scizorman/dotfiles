#!/usr/bin/env zsh
case "$(uname)" in
  'Linux')
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    ;;
  'Darwin')
    eval "$(/opt/homebrew/bin/brew shellenv)"
    source ~/.orbstack/shell/init.zsh 2>/dev/null || :
    ;;
esac

export \
  EDITOR='hx' \
  PAGER='bat' \
  GPG_TTY="$(tty)"

if [[ $(uname -r) =~ 'microsoft' ]]; then
  export \
    AWS_VAULT_BACKEND='pass' \
    AWS_VAULT_PASS_PREFIX='aws-vault'
fi

export \
  POETRY_VIRTUALENVS_IN_PROJECT=true \
  VOLTA_HOME="${HOME}/.volta"

path=( \
  ${VOLTA_HOME}/bin(N-/) \
  ${HOMEBREW_PREFIX}/opt/*/libexec/gnubin(N-/) \
  ${HOMEBREW_PREFIX}/opt/libpq/bin(N-/) \
  ${HOMEBREW_PREFIX}/opt/mysql-client/bin(N-/) \
  ${HOME}/.local/bin(N-/) \
  $path \
)
manpath=( \
  ${HOMEBREW_PREFIX}/opt/*/libexec/gnuman(N-/) \
  $manpath \
)
fpath=( \
  ${BUN_INSTALL}(N-/) \
  ${ZDOTDIR}/site-functions(N-/) \
  $fpath
)

eval "$(mise activate zsh --shims)"

mkdir -p "${ZDOTDIR}/site-functions"
docker completion zsh >! "${ZDOTDIR}/site-functions/_docker"
mise completion zsh >! "${ZDOTDIR}/site-functions/_mise"
deno completions zsh >! "${ZDOTDIR}/site-functions/_deno"
rustup completions zsh rustup >! "${ZDOTDIR}/site-functions/_rustup"
rustup completions zsh cargo >! "${ZDOTDIR}/site-functions/_cargo"
aws-vault --completion-script-zsh >! "${ZDOTDIR}/site-functions/_aws-vault"
volta completions -f --quiet -o "${ZDOTDIR}/site-functions/_volta" zsh
