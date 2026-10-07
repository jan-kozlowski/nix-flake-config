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
    starship
    obsidian
  ];

  developmentPackages = with pkgs; [
    git
    gnumake
    # rust language
    cargo
    rustc

    # language servers
    lua-language-server
    nil
    nixd
  ];
in
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = essentialPackages ++ nonEssentialPackages ++ developmentPackages;
}
