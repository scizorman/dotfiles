.DEFAULT_GOAL := install

.DELETE_ON_ERROR:
.INTERMEDIATE: install-homebrew.sh get-poetry.py install-deno.sh google-cloud-sdk.tar.gz

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

anyenv := $(HOME)/.anyenv
$(anyenv):
	@git clone https://github.com/anyenv/anyenv.git $@
	@$@ install --init

sdkman := $(HOME)/.sdkman
$(sdkman):
	@curl -s 'https://get.sdkman.io?rcuupdate=false' | bash

poetry := $(HOME)/.poetry
get-poetry.py:
	@curl -sSL 'https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py' -o $@
$(poetry): get-poetry.py
	@python3 $< --no-modify-path --yes

rustup := $(HOME)/.cargo/bin/rustup
$(rustup):
	@curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

deno := $(HOME)/.deno/bin/deno
install-deno.sh:
	@curl -fsSL https://deno.land/x/install/install.sh -o $@
$(deno): install-deno.sh
	@sh $<

google-cloud-sdk := $(HOME)/google-cloud-sdk
google-cloud-sdk.tar.gz:
	@curl -sSL https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-319.0.0-darwin-x86_64.tar.gz -o $@
$(google-cloud-sdk): google-cloud-sdk.tar.gz
	@tar zxvf $< -C $(@D)

install: $(brew) $(zinit) $(anyenv) $(sdkman) $(poetry) $(rustup) $(deno) $(google-cloud-sdk)

.PHONY: install
