{ ... }: {

  imports = [ ./hardware.nix ];

  networking.hostName = "W530"; # Define your hostname.

  bchmnn = {

    gui = {
      enable = true;
      flavour = [ "sway" "i3" ];
    };
    nvidia.enable = false;
    audio.enable = true;
    bluetooth.enable = true;
    vpn.enable = true;
    
    devenv.enable = true;
    virtualisation.enable = true;
    games.enable = true;

  };

}
