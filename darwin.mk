CONFIG ?= groomed

.PHONY: build
build:
	darwin-rebuild build --flake '.#$(CONFIG)'

.PHONY: diff
diff: build
	nix store diff-closures /run/current-system ./result

.PHONY: switch
switch:
	sudo darwin-rebuild switch --flake '.#$(CONFIG)'
