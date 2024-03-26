{ ... }: {

  imports = [ ./hardware.nix ];

  networking.hostName = "IROH";

  services.syncthing = {
    settings = {
      devices = {
        IROH = {
          id = "PJA2MBA-66PQQEO-5KICONS-FGHDH46-YRV2X5Y-47UUP77-QXI2WNS-R33FPAK";
        };
      };
    };
  };

  bchmnn = {

    gui = {
      enable = true;
      greeter.enable = true;
      flavour = [ "Hyprland" "sway" "i3" ];
    };
    nvidia.enable = true;
    audio.enable = true;
    bluetooth.enable = true;
    printing.enable = true;
    vpn.enable = true;

    devenv.enable = true;
    virtualisation.enable = true;
    games.enable = true;

  };

}
