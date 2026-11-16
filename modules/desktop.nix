{
  config,
  pkgs,
  lib,
  ...
}:
let
  cursorName = "Bibata-Modern-Ice";
  cursorSize = 24;
in
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    SDL_VIDEODRIVER = "x11";
    SDL_VIDEO_DRIVER = "x11";
    XCURSOR_THEME = cursorName; # Hyprland + aplikacje X11/XWayland
    XCURSOR_SIZE = toString cursorSize;
  };

  xdg.icons.fallbackCursorThemes = [ cursorName ];

  services.greetd = {
    enable = true;
  };

  programs.regreet = {
    enable = true;
    cursorTheme = {
      name = cursorName;
      package = pkgs.bibata-cursors;
    };
  };

  programs.dconf.profiles.user.databases = [
    {
      settings."org/gnome/desktop/interface" = {
        cursor-theme = cursorName;
        cursor-size = lib.gvariant.mkInt32 cursorSize;
      };
    }
  ];

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
