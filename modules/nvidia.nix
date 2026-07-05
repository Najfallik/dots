{ config, lib, pkgs, ... }:
{
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = false;
  	modesetting.enable = true;
  	nvidiaSettings = true;
  	package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
  };

  environment.sessionVariables = {
  	WLR_NO_HARDWARE_CURSORS = "1"; # keep only if mouse plane is glitched
  };
}
