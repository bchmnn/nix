{ config, lib, ... }: lib.mkIf config.bchmnn.gui.enable {
  programs.ausweisapp = {
    enable = true;
    openFirewall = true;
  };
}
