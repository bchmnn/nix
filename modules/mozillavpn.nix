{ config, lib, pkgs, ... }: lib.mkIf config.bchmnn.vpn.enable {

  environment.systemPackages = with pkgs; [
    mozillavpn
  ];

  services.mozillavpn = {
    enable = true;
  };

}
