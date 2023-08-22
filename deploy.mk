.DELETE_ON_ERROR:

SHELL := /bin/bash

OS              := $(shell uname -s)
XDG_CONFIG_HOME := $(HOME)/.config

dotfiles := \
	.Brewfile \
	.gitignore-global \
	.ideavimrc \
	.tmux.conf \
	.vscodevimrc \
	.zsh \
	.zshenv

xdg_configs := \
	helix \
	nvim \
	starship.toml

deploy_targets := $(addprefix $(HOME)/,$(dotfiles)) $(addprefix $(XDG_CONFIG_HOME)/,$(xdg_configs))

.PHONY: all
all:
	@more $(MAKEFILE_LIST)

.PHONY: clean
clean:
	-rm -r $(deploy_targets)

.PHONY: deploy
deploy: $(deploy_targets)

$(HOME)/% $(XDG_CONFIG_HOME)/%: %
	ln -sfnv $(abspath $<) $@
$(HOME)/.Brewfile: .Brewfile.$(shell echo $(OS) | tr '[:upper:]' '[:lower:]')
	ln -sfnv $(abspath $<) $@
