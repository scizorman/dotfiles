CONFIG ?= groomed

rebuild := darwin-rebuild
current_system := /run/current-system

.PHONY: switch
switch:
	$(rebuild) switch --flake '.#$(CONFIG)'
