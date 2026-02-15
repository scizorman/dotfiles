.PHONY: all
all:
	@more $(MAKEFILE_LIST)

uname := $(shell uname -s)
ifeq ($(uname),Linux)
ifneq ($(wildcard /etc/NIXOS),)
manager := nixos
endif
else ifeq ($(uname),Darwin)
manager := darwin
else
$(error Unsupported OS: $(uname))
endif

include $(manager).mk

.PHONY: clean gc
clean: gc
	rm -f result
gc:
	nix-collect-garbage --delete-old

.PHONY: check
check:
	nix flake check

.PHONY: fmt
fmt:
	nix fmt

.PHONY: update
update:
	nix flake update

.PHONY: build
build:
	$(rebuild) build --flake '.#$(CONFIG)'

.PHONY: diff
diff: build
	nix store diff-closures $(current_system) ./result
