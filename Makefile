SHELL := /bin/bash

OS := $(shell uname -s)

.PHONY: all
all:
	@more $(MAKEFILE_LIST)

.PHONY: clean
clean:
	$(MAKE) -f deploy.mk $@
	$(MAKE) -f install.mk $@

.PHONY: update
update:
	git pull origin main

.PHONY: deploy
deploy: update
	$(MAKE) -f deploy.mk $@ OS=$(OS)

.PHONY: install
install: deploy
	$(MAKE) -f install.mk $@ OS=$(OS)
