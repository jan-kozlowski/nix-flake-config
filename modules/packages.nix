{
  pkgs,
  inputs,
  ...
}:
let
  essentialPackages = with pkgs; [
    # text editor
    zed-editor
    # terminal emulator
    kitty
    # file manager
    inputs.hyprfm.packages."${pkgs.stdenv.hostPlatform.system}".default
    # browser
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
    # desktop shell
    noctalia
  ];

  nonEssentialPackages = with pkgs; [
    spotify
    chafa
    fastfetch
    chezmoi
    zoxide
    bat
    eza
    obsidian
  ];

  developmentPackages = with pkgs; [
    git
    gnumake
    gcc
    # rust language
    cargo
    rustc
    rustfmt
    clippy
    rust-analyzer

    # language servers
    lua-language-server
    nixd
  ];
in
{
  nixpkgs.config.allowUnfree = true;

  programs = {
    nix-ld.enable = true;
    starship.enable = true;
    starship.transientPrompt.enable = true;
  };

  environment.systemPackages = essentialPackages ++ nonEssentialPackages ++ developmentPackages;
}
