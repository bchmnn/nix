{ ... }: {

  imports = [ ./hardware.nix ];

  networking.hostName = "T430";

  bchmnn = {

    gui = {
      enable = true;
      flavour = [ "sway" "hyprland" ];
    };
    nvidia.enable = false;
    audio.enable = true;
    bluetooth.enable = true;
    printing.enable = true;
    vpn.enable = true;

    devenv.enable = true;
    virtualisation.enable = true;
    games.enable = true;

  };

}
