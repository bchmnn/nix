{ config, lib, pkgs, ... }: lib.mkIf config.bchmnn.nvidia.enable {

  services.xserver.videoDrivers = [ "nouveau" ];

  # services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Modesetting is needed for most Wayland compositors
    modesetting.enable = true;
    # Use the open source version of the kernel module
    # Only available on driver 515.43.04+
    open = false;
    # Enable the nvidia settings menu
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_390;
  };

}
