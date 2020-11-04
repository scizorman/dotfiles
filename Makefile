.DEFAULT_GOAL := help

candidates := $(wildcard .??*)
exclusions := .DS_Store .git .gitignore
dotfiles   := $(filter-out $(exclusions),$(candidates))

## list: Show dotfiles in this repository
list:
	@$(foreach val,$(dotfiles),/bin/ls -dF $(val);)

## update: Fetch changes for this repository
update:
	@git pull origin main

## deploy: Create the symlink to home directory
deploy:
	@$(foreach dotfile,$(dotfiles),ln -sfnv $(abspath $(dotfile)) $(HOME)/$(dotfile);)

## install: Setup environments and install programs
install: update deploy
	$(MAKE) -f install.mk

## clean: Remove the dot files and this repository
clean:
	$(info Remove dotfiles in your home directory...)
	@-$(foreach dotfile,$(dotfiles),unlink $(HOME)/$(dotfile);)

## help: Show this help message
help:
	@grep -E '^## [a-zA-Z_-]+: .*$$' $(MAKEFILE_LIST) \
		| tr -d '##' \
		| awk 'BEGIN {FS = ":"}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: list update deploy install clean help
