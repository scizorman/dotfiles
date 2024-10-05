OS := $(shell uname -s)

.PHONY: all
all:
	@more $(MAKEFILE_LIST)

.PHONY: clean
clean:
	$(MAKE) -f install.mk $@

.PHONY: update
update:
	git pull origin main

.PHONY: install
install: update
	$(MAKE) -f install.mk $@ OS=$(OS)
