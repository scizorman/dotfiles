SHELL := /bin/bash -e -o pipefail

candidates := $(wildcard .??*)
exclusions := $(wildcard .Brewfile.*) .DS_Store .git .gitignore
dotfiles   := $(filter-out $(exclusions),$(candidates))

all: help

.Brewfile:
	@ln -sfn .Brewfile.$(shell uname | tr [A-Z] [a-z]) $@

## list: Show dotfiles in this repository
list: .Brewfile
	@$(foreach val,$(dotfiles),/bin/ls -dF $(val);)

## update: Fetch changes for this repository
update:
	@git pull origin main

## deploy: Create the symlink to home directory
deploy: .Brewfile
	@$(foreach dotfile,$(dotfiles),ln -sfnv $(abspath $(dotfile)) $(HOME)/$(dotfile);)

## install: Setup environments and install programs
install: update deploy
	@$(MAKE) -f install.mk
	@exec $$SHELL -l

## clean: Remove the dot files and this repository
clean:
	$(info Remove dotfiles in your home directory...)
	@-$(foreach dotfile,$(dotfiles),unlink $(HOME)/$(dotfile);)

## help: Show this help message
help:
	@grep -E '^## [a-zA-Z_-]+: .*$$' $(MAKEFILE_LIST) \
		| tr -d '##' \
		| awk 'BEGIN {FS = ":"}; {printf "%-30s %s\n", $$1, $$2}'

.PHONY: all list update deploy install clean help
