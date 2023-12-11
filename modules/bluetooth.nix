{ config, lib, ... }: lib.mkIf config.bchmnn.bluetooth.enable {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.blueman.enable = true;
}
