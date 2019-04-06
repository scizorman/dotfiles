DOTPATH := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*) bin node_modules package.json package-lock.json
EXCLUSIONS := .DS_Store .git .gitmodules .gitignore
DOTFILES := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

list: ## show dot files in this repository
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

update: ## fetch changes for this repository
	git pull origin master
	git submodule init
	git submodule update
	git submodule foreach git pull origin master

deploy: ## create the symlink to home directory
	@echo ''
	@echo '==> Start to deploy dotfiles to home directory.'
	@echo ''
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	@echo ''

init: ## setup environment settings
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/init/init.sh

install: update deploy init ## run update, deploy and init
	@exec $$SHELL

clean: ## remove the dot files and this repository
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES), unlink $(HOME)/$(val);)
	-rm -rf $(DOTPATH)
