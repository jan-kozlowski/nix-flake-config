{
  pkgs,
  inputs,
  ...
}:
let
  essentialPackages = with pkgs; [
    kitty
    git
    gnumake
    chezmoi
    zoxide
    bat
    exa
    starship
    zed-editor
    obsidian
    noctalia

    inputs.hyprfm.packages."${pkgs.stdenv.hostPlatform.system}".default
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
  ];

  nonEssentialPackages = with pkgs; [
    spotify
    chafa
    fastfetch
  ];

  developmentPackages = with pkgs; [
    cargo
    rustc

    # language servers
    lua-language-server
    nil
    nixd
  ];
in
{
  environment.systemPackages = essentialPackages ++ nonEssentialPackages ++ developmentPackages;
}
