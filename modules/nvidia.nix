{ config, lib, ... }: lib.mkIf config.bchmnn.nvidia.enable {

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    nvidiaSettings = true;
  };

}
