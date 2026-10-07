{ config, pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
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
