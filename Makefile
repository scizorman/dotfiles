ROOT_PATH := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

help:
	@echo "usage: make [COMMANDS]"
	@echo
	@echo "COMMANDS:"
	@echo "    deploy    Deploy dotfiles"
	@echo "    init      Install packages"
	@echo "    install   Exec 'deploy' and 'init'"
	@echo "    update    Update dotfiles (git pull)"
	@echo "    clean     Remove dotfiles"

deploy:
	@echo '==> Start to deploy dotfiles and binfiles.'
	@DOTPATH=$(ROOT_PATH) sh $(ROOT_PATH)/etc/deploy.sh

install:
	@echo '==> Start to install necessary packages.'
	@DOTPATH=$(ROOT_PATH) sh $(ROOT_PATH)/etc/install.sh

init: deploy install
	@exec $$SHELL

update:
	@echo '==> Start to update.'
	@DOTPATH=$(ROOT_PATH) sh $(ROOT_PATH)/etc/update.sh

clean:
	@echo '==> Start to clean .dotfiles.'
	@DOTPATH=$(ROOT_PATH) sh $(ROOT_PATH)/etc/clean.sh
