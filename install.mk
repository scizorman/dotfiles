.DELETE_ON_ERROR:

SHELL := /bin/bash

OS := $(shell uname -s)

ifeq ($(OS),Linux)
	brew := /home/linuxbrew/.linuxbrew/bin/brew
else
	brew := /usr/local/bin/brew
endif

zinit            := $(HOME)/.zsh/.zinit
volta            := $(HOME)/.volta
sdkman           := $(HOME)/.sdkman
rye              := $(HOME)/.rye
poetry           := $(HOME)/.local/bin/poetry
rustup           := $(HOME)/.cargo/bin/rustup
deno             := $(HOME)/.deno
google_cloud_sdk := $(HOME)/google-cloud-sdk

tools := \
	$(brew) \
	$(volta) \
	$(sdkman) \
	$(rye) \
	$(poetry) \
	$(rustup) \
	$(deno) \
	$(google_cloud_sdk)

.PHONY: all
all:
	@more $(MAKEFILE_LIST)

.PHONY: clean
clean:
	-rm -rf $(tools)

.PHONY: install
install: $(tools)

$(brew): install-homebrew.sh
	bash $<
.INTERMEDIATE: install-homebrew.sh
install-homebrew.sh:
	curl -fsSL 'https://raw.githubusercontent.com/Homebrew/install/master/install.sh' -o $@

$(volta):
	curl https://get.volta.sh | bash

$(sdkman):
	curl -s https://get.sdkman.io | bash

$(rye):
	curl -fsS 'https://rye-up.com/get' | bash

$(poetry):
	curl -sSL 'https://install.python-poetry.org' | python3 -

$(rustup):
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

$(deno):
	curl -fsSL https://deno.land/install.sh | sh

$(google-cloud-sdk):
	curl https://sdk.cloud.google.com | bash
