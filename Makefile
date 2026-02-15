.PHONY: all
all:
	@more $(MAKEFILE_LIST)

ifneq ($(shell command -v nixos-rebuild 2>/dev/null),)
include nixos.mk
else ifneq ($(shell command -v darwin-rebuild 2>/dev/null),)
include darwin.mk
endif

.PHONY: clean gc
clean: gc
	rm -f result
gc:
	nix-collect-garbage --delete-old

.PHONY: fmt
fmt:
	nix fmt

.PHONY: check
check:
	nix flake check

.PHONY: update
update:
	nix flake update
