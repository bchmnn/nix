{ pkgs, ... }: {
  networking.networkmanager.enable = true;

  systemd.services = {
    NetworkManager-wait-online.enable = false;
  };

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };
}
