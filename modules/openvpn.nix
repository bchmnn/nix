{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    openvpn3
  ];
}
