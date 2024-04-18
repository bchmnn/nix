{ ... }: {

  imports = [ ./hardware.nix ];

  networking.hostName = "W530";

  bchmnn = {

    gui = {
      enable = true;
      greeter.enable = true;
      flavour = [ "sway" "i3" ];
    };
    nvidia.enable = false;
    audio.enable = true;
    bluetooth.enable = true;
    printing.enable = true;
    vpn.enable = true;

    devenv.enable = true;
    virtualisation.enable = true;
    games.enable = false;
    ratbag.enable = true;

    ai.enable = false;

  };

}
