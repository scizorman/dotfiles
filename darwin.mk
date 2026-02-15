CONFIG ?= groomed

rebuild := darwin-rebuild
current_system := /run/current-system

.PHONY: switch
switch:
	sudo $(rebuild) switch --flake '.#$(CONFIG)'
