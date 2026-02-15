CONFIG ?= $(shell hostname -s)

.PHONY: build
build:
	nixos-rebuild build --flake '.#$(CONFIG)'

.PHONY: diff
diff: build
	nix store diff-closures /run/current-system ./result

.PHONY: test
test:
	sudo nixos-rebuild test --flake '.#$(CONFIG)'

.PHONY: switch
switch:
	sudo nixos-rebuild switch --flake '.#$(CONFIG)'
