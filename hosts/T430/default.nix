{ ... }: {


  imports = [ ./hardware.nix ];

  networking.hostName = "T430";

  bchmnn = {

    gui = {
      enable = true;
      greeter.enable = true;
      flavour = [ "Hyprland" "sway" ];
    };
    nvidia.enable = false;
    audio.enable = true;
    bluetooth.enable = true;
    printing.enable = true;
    vpn.enable = true;

    devenv.enable = true;
    virtualisation.enable = true;
    games.enable = true;
    ratbag.enable = true;

    ai.enable = false;

  };

}
