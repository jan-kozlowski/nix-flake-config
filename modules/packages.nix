{
  pkgs,
  inputs,
  ...
}:
let
  unstable-pkgs = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };

  essentialPackages = with pkgs; [
    # text editor
    zed-editor
    # terminal emulator
    kitty
    # file manager
    inputs.hyprfm.packages."${pkgs.stdenv.hostPlatform.system}".default
    gvfs
    # browser
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
    # desktop shell
    noctalia
    bibata-cursors
  ];

  nonEssentialPackages = with pkgs; [
    octaveFull
    appimage-run
    libreoffice
    spotify
    chafa
    chezmoi
    zoxide
    bat
    eza
    obsidian
    ffmpeg
    exiftool
  ];

  developmentPackages = with pkgs; [
    git
    gh
    lazygit
    gnumake
    gcc
    clang

    unstable-pkgs.mdbook
    unstable-pkgs.mdbook-mermaid

    # rust language
    rustup

    # language servers
    lua-language-server
    nixd
    nil
    clang-tools
  ];
in
{
  nixpkgs.config.allowUnfree = true;

  programs = {
    nix-ld.enable = true;
    starship.enable = true;
  };

  environment.systemPackages = essentialPackages ++ nonEssentialPackages ++ developmentPackages;
}
