.DELETE_ON_ERROR:

OS              := $(shell uname -s)
XDG_CONFIG_HOME := $(HOME)/.config

dotfiles := \
	.Brewfile \
	.ideavimrc \
	.tmux.conf \
	.vscodevimrc \
	.zsh \
	.zshenv

xdg_configs := \
	git \
	helix \
	mise \
	nvim \
	sheldon \
	zellij

deploy_targets := $(addprefix $(HOME)/,$(dotfiles)) $(addprefix $(XDG_CONFIG_HOME)/,$(xdg_configs))

.PHONY: all
all:
	@more $(MAKEFILE_LIST)

.PHONY: clean
clean:
	-rm -r $(deploy_targets)

.PHONY: deploy
deploy: $(deploy_targets)

$(HOME)/%: %
$(HOME)/.Brewfile: .Brewfile.$(shell echo $(OS) | tr '[:upper:]' '[:lower:]')
	ln -sfnv $(abspath $<) $@
$(XDG_CONFIG_HOME)/%: %
	ln -sfnv $(abspath $<) $@
