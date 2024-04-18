{ ... }: {

  imports = [ ./hardware.nix ];

  networking.hostName = "IROH";

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
    ratbag.enable = true;

    ai.enable = false;

  };

}
