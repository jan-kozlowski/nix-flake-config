{
  description = "NixOS flake configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    hyprfm.url = "github:soyeb-jim285/hyprfm";
  };

  outputs =
    {
      nixpkgs,
      ...
    }@inputs:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          ./desktop.nix
          ./packages.nix
          ./gaming.nix
        ];
      };
    };
}
