#!/usr/bin/env zsh
case "$(uname)" in
  'Linux')
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    ;;
  'Darwin')
    eval "$(/opt/homebrew/bin/brew shellenv)"
    ;;
esac

export EDITOR='hx'
export PAGER='bat'

export GOPATH="${GOPATH:-$HOME/go}"
export POETRY_VIRTUALENVS_IN_PROJECT=true
export BUN_INSTALL="${HOME}/.bun"
export DENO_INSTALL="${HOME}/.deno"
export VOLTA_HOME="${HOME}/.volta"

if [[ $(uname -r) =~ 'microsoft' ]]; then
  export AWS_VAULT_BACKEND='pass'
  export AWS_VAULT_PASS_PREFIX='aws-vault'
  export GPG_TTY="$(tty)"
fi

path=( \
  ${GOPATH}/bin(N-/) \
  ${BUN_INSTALL}/bin(N-/) \
  ${DENO_INSTALL}/bin(N-/) \
  ${VOLTA_HOME}/bin(N-/) \
  ${HOME}/.cargo/bin(N-/) \
  ${HOMEBREW_PREFIX}/opt/*/libexec/gnubin(N-/) \
  ${HOMEBREW_PREFIX}/opt/libpq/bin(N-/) \
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

mkdir -p "${ZDOTDIR}/site-functions"
poetry completions zsh >! "${ZDOTDIR}/site-functions/_poetry"
deno completions zsh >! "${ZDOTDIR}/site-functions/_deno"
volta completions -f --quiet -o "${ZDOTDIR}/site-functions/_volta" zsh
rustup completions zsh rustup >! "${ZDOTDIR}/site-functions/_rustup"
rustup completions zsh cargo >! "${ZDOTDIR}/site-functions/_cargo"
docker completion zsh >! "${ZDOTDIR}/site-functions/_docker"
aws-vault --completion-script-zsh >! "${ZDOTDIR}/site-functions/_aws-vault"
