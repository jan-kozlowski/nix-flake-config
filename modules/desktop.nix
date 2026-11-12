{ config, pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    SDL_VIDEODRIVER = "x11";
    SDL_VIDEO_DRIVER = "x11";
  };

  programs.regreet.enable = true;
  services.greetd = {
    enable = true;
  };

  # required for hyprfm
  services.gvfs.enable = true;
  systemd.tmpfiles.rules = [
    "d /usr/share 0755 root root -"
    "L+ /usr/share/gvfs - - - - ${config.services.gvfs.package}/share/gvfs"
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
  fonts.fontconfig.defaultFonts.monospace = [ "JetBrainsMono Nerd Font" ];
}
