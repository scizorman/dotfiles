.DELETE_ON_ERROR:

OS := $(shell uname -s)

ifeq ($(OS),Linux)
	brew := /home/linuxbrew/.linuxbrew/bin/brew
else
	brew := /opt/homebrew/bin/brew
endif

mise := $(HOME)/.local/bin/mise

tools := \
	$(brew) \
	$(mise)

.PHONY: all
all:
	@more $(MAKEFILE_LIST)

.PHONY: clean
clean:
	-rm -rf $(tools)

.PHONY: install
install: $(tools)

$(brew): install-homebrew.sh
	bash $<
.INTERMEDIATE: install-homebrew.sh
install-homebrew.sh:
	curl -fsSL 'https://raw.githubusercontent.com/Homebrew/install/master/install.sh' -o $@

$(mise):
	curl -fsSL 'https://mise.run' | sh
