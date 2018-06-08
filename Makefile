DOTPATH := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*) bin
EXCLUSIONS := .DS_Store .git .gitmodules .gitignore
DOTFILES := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

all:

list:
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

deploy:
	@echo '==> Start to deploy dotfiles to home directory.'
	@echo ''
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	@echo ''
	@echo 'Deploy: Complete!'

init:
	@DOTPATH=$(DOTPATH) sh $(DOTPATH)/etc/init/init.sh
	@echo ''
	@echo 'Initalize: Complete!'

update:
	git pull origin master
	git submodule init
	git submodule update
	git submodule foreach git pull origin master
	@echo ''
	@echo 'Update: Complete!'

install: update deploy init
	@exec $$SHELL
	@echo ''
	@echo 'Install: Complete!'

clean:
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES), unlink $(HOME)/$(val);)
	@echo ''
	@echo 'Clean: Complete!'

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
