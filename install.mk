SHELL := /bin/bash -e -o pipefail

os := $(shell uname -s)
ifeq ($(os),Linux)
	brew := /home/linuxbrew/.linuxbrew/bin/brew
else
	brew := /usr/local/bin/brew
endif

all: install

$(brew): install-homebrew.sh
	@bash $<
install-homebrew.sh:
	@curl -fsSL 'https://raw.githubusercontent.com/Homebrew/install/master/install.sh' -o $@

zinit := $(HOME)/.zsh/.zinit
$(zinit):
	@git clone https://github.com/zdharma-continuum/zinit.git $@/bin

rustup := $(HOME)/.cargo/bin/rustup
$(rustup):
	@curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

poetry := $(HOME)/.local/bin/poetry
$(poetry):
	@curl -sSL 'https://install.python-poetry.org' | python3 -

sdkman := $(HOME)/.sdkman
$(sdkman):
	@curl -s https://get.sdkman.io | bash

volta := $(HOME)/.volta
$(volta):
	@curl https://get.volta.sh | bash

deno := $(HOME)/.deno
$(deno):
	@curl -fsSL https://deno.land/install.sh | sh

google-cloud-sdk := $(HOME)/google-cloud-sdk
$(google-cloud-sdk):
	@curl https://sdk.cloud.google.com | bash

install: $(brew) $(zinit) $(rustup) $(poetry) $(sdkman) $(volta) $(deno) $(google-cloud-sdk)

.PHONY: all install
.DELETE_ON_ERROR:
.INTERMEDIATE: install-homebrew.sh
