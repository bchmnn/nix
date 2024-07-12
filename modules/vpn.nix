{ pkgs, lib, config, ... }: lib.mkIf config.bchmnn.vpn.enable {

  environment.systemPackages = with pkgs; [
    openvpn3
    mullvad-vpn
  ];

  services.mullvad-vpn.enable = true;

}
