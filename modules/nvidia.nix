{ ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    powerManagement.enable = true;
    modesetting.enable = true;
    open = true;
  };
}
