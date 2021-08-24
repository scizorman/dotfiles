.DEFAULT_GOAL := install

.DELETE_ON_ERROR:
.INTERMEDIATE: install-homebrew.sh install-poetry.py google-cloud-sdk.tar.gz

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
	@$@ bundle --global

zinit := $(HOME)/.zsh/.zinit
$(zinit):
	@git clone https://github.com/zdharma/zinit.git $@/bin

sdkman := $(HOME)/.sdkman
$(sdkman):
	@curl -s 'https://get.sdkman.io?rcupdate=false' | bash

poetry := $(HOME)/.poetry
install-poetry.py:
	@curl -sSL 'https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py' -o $@
$(poetry): install-poetry.py
	@python3 $< --yes

rustup := $(HOME)/.cargo/bin/rustup
$(rustup):
	@curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

google-cloud-sdk := $(HOME)/google-cloud-sdk
$(google-cloud-sdk):
	@curl https://sdk.cloud.google.com | bash

install: $(brew) $(zinit) $(sdkman) $(poetry) $(rustup) $(google-cloud-sdk)

.PHONY: install
