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
    # browser
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
    # desktop shell
    noctalia
    bibata-cursors
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

    # c libraries
    libGL
    libGLU
    libtiff
    libx11
    freeglut
    glm
    glfw
    glew
    mesa-demos
    pkg-config
    libx11
    libxcursor
    libxrandr
    libxi
    libxinerama
    xorgproto
    wayland
    libxkbcommon

    # rust language
    cargo
    rustc
    rustfmt
    clippy

    # language servers
    lua-language-server
    nixd
    nil
    rust-analyzer
    clang-tools
  ];
in
{
  nixpkgs.config.allowUnfree = true;

  programs = {
    nix-ld.enable = true;
    starship.enable = true;
  };

  environment.extraOutputsToInstall = [ "dev" ];
  environment.systemPackages = essentialPackages ++ nonEssentialPackages ++ developmentPackages;
  environment.pathsToLink = [
    "/include"
    "/lib/pkgconfig"
    "/share/pkgconfig"
    "/lib/cmake"
  ];
  environment.sessionVariables = {
    C_INCLUDE_PATH = "/run/current-system/sw/include";
    CPLUS_INCLUDE_PATH = "/run/current-system/sw/include";
    LIBRARY_PATH = "/run/current-system/sw/lib";
    PKG_CONFIG_PATH = "/run/current-system/sw/lib/pkgconfig:/run/current-system/sw/share/pkgconfig";
    CMAKE_PREFIX_PATH = "/run/current-system/sw";
  };

  environment.sessionVariables.LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (
    with pkgs;
    [
      libGL
      glfw
      libx11
      libxcursor
      libxrandr
      libxi
      libxinerama
      wayland
      libxkbcommon
    ]
  );
}
