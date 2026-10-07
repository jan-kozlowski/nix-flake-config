.PHONY: rebuild test

rebuild:
	sudo nixos-rebuild switch --flake .

test:
	sudo nixos-rebuild test --flake .
