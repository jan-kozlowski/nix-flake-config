.PHONY: rebuild test

test:
	sudo nixos-rebuild test --flake .

switch:
	sudo nixos-rebuild switch --flake .
