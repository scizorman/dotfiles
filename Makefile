.DEFAULT_GOAL := help

DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git .gitignore
DOTFILES   := $(filter-out $(EXCLUSIONS),$(CANDIDATES))

## list: show dot files in this repository
list:
	@$(foreach val,$(DOTFILES),/bin/ls -dF $(val);)

## update: fetch changes for this repository
update:
	@git pull origin main

## deploy: create the symlink to home directory
deploy:
	@echo ''
	@echo '==> start to deploy dotfiles to home directory.'
	@echo ''
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	@echo ''

## list: setup environment settings
init:
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/init/init.sh

## run update, deploy and init
install: update deploy init ## run update, deploy and init
	@exec $$SHELL -l

## clean: remove the dot files and this repository
clean:
	@echo 'remove dot files in your home directory...'
	@-$(foreach val,$(DOTFILES),unlink $(HOME)/$(val);)
	-rm -rf $(DOTPATH)

## help: show this help message
help:
	@grep -E '^## [a-zA-Z_-]+: .*$$' $(MAKEFILE_LIST) \
		| tr -d '##' \
		| sort \
		| awk 'BEGIN {FS = ":"}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: list update deploy init install clean help
