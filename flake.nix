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
    let
      host =
        hostName:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs hostName; };
          modules = [
            ./hosts/${hostName}
            ./modules/configuration.nix
            ./modules/desktop.nix
            ./modules/packages.nix
            ./modules/gaming.nix
          ];
        };
    in
    {
      nixosConfigurations = {
        pc = host "pc";
        laptop = host "laptop";
      };
    };
}
