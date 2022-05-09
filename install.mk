.DEFAULT_GOAL := install

.DELETE_ON_ERROR:
.INTERMEDIATE: install-homebrew.sh

os := $(shell uname -s)
ifeq ($(os),Linux)
	brew := /home/linuxbrew/.linuxbrew/bin/brew
else
	brew := /usr/local/bin/brew
endif

install-homebrew.sh:
	@curl -fsSL 'https://raw.githubusercontent.com/Homebrew/install/master/install.sh' -o $@
$(brew): install-homebrew.sh
	@bash $<

zinit := $(HOME)/.zsh/.zinit
$(zinit):
	@git clone https://github.com/zdharma-continuum/zinit.git $@/bin

poetry := $(HOME)/.local/bin/poetry
$(poetry):
	@curl -sSL 'https://install.python-poetry.org' | python3 -

rustup := $(HOME)/.cargo/bin/rustup
$(rustup):
	@curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

deno := $(HOME)/.deno
$(deno):
	@curl -fsSL https://deno.land/install.sh | sh

sdkman := $(HOME)/.sdkman
$(sdkman):
	@curl -s https://get.sdkman.io | bash

google-cloud-sdk := $(HOME)/google-cloud-sdk
$(google-cloud-sdk):
	@curl https://sdk.cloud.google.com | bash

install: $(brew) $(zinit) $(poetry) $(rustup) $(deno) $(sdkman) $(google-cloud-sdk)

.PHONY: install
