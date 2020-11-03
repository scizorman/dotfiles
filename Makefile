.DEFAULT_GOAL := help

candidates := $(wildcard .??*)
exclusions := .DS_Store .git .gitignore
dotfiles   := $(filter-out $(exclusions),$(candidates))

## list: show dotfiles in this repository
list:
	@$(foreach val,$(dotfiles),/bin/ls -dF $(val);)

## update: fetch changes for this repository
update:
	@git pull origin main

## deploy: create the symlink to home directory
deploy:
	@echo ''
	$(info Start to deploy dotfiles to home directory)
	@$(foreach dotfile,$(dotfiles),ln -sfnv $(abspath $(dotfile)) $(HOME)/$(dotfile);)
	@echo ''

## install: setup environments and install CLI tools
install: update deploy
	$(MAKE) -f install.mk install
	@exec $$SHELL -l

## clean: remove the dot files and this repository
clean:
	$(info Remove dotfiles in your home directory...)
	@-$(foreach dotfile,$(dotfiles),unlink $(HOME)/$(dotfile);)

## help: show this help message
help:
	@grep -E '^## [a-zA-Z_-]+: .*$$' $(MAKEFILE_LIST) \
		| tr -d '##' \
		| awk 'BEGIN {FS = ":"}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: list update deploy install clean help
