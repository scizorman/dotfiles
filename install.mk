.DEFAULT_GOAL := install

brew := /usr/local/bin/brew
$(brew):
	@bash -c '$(shell curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)'
	@brew bundle --global

zinit := $(HOME)/.zsh/.zinit
$(zinit):
	@git clone https://github.com/zdharma/zinit.git $@/bin

anyenv := $(HOME)/.anyenv
$(anyenv):
	@git clone https://github.com/anyenv/anyenv.git $@

sdkman := $(HOME)/.sdkman
$(sdkman):
	@curl -s 'https://get.sdkman.io?rcuupdate=false' | bash
	@source $@/bin/sdkman-init.sh

poetry := $(HOME)/.poetry
$(poetry):
	@curl -sSL 'https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py' | python

rustup := $(HOME)/.cargo/bin/rustup
$(rustup):
	@curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

install: $(brew) $(zinit) $(anyenv) $(poetry) $(rustup)
	@exec $$SHELL -l

.PHONY: install
