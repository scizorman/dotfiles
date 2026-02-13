CONFIG ?= $(shell hostname -s)

rebuild := nixos-rebuild
current_system := /run/current-system

.PHONY: test
test:
	sudo $(rebuild) test --flake '.#$(CONFIG)'

.PHONY: switch
switch:
	sudo $(rebuild) switch --flake '.#$(CONFIG)'
