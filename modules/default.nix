{ lib, ... }: {

  # options affecting multiple modules
  options.bchmnn = with lib; {

    gui = {
      enable = mkEnableOption "gui";
      greeter = {
        enable = mkEnableOption "greeter";
      };
      flavour = mkOption {
        type = types.listOf types.str;
        default = [ "sway" ];
        example = [ "sway" "i3" "Hyprland" ];
        description = ''
          The flavour (WM) for your system to use
        '';
      };
    };

    nvidia = {
      enable = mkEnableOption "nvidia";
    };

    audio = {
      enable = mkEnableOption "audio";
    };

    bluetooth = {
      enable = mkEnableOption "bluetooth";
    };

    printing = {
      enable = mkEnableOption "printing";
    };

    vpn = {
      enable = mkEnableOption "vpn";
    };

    devenv = {
      enable = mkEnableOption "devenv";
    };

    virtualisation = {
      enable = mkEnableOption "virtualisation";
    };

    games = {
      enable = mkEnableOption "games";
    };

  };

  imports = [
    ./audio.nix
    ./ausweisapp.nix
    ./bluetooth.nix
    ./dbus.nix
    ./fonts.nix
    ./greetd.nix
    ./gstreamer.nix
    ./i18n.nix
    ./kdeconnect.nix
    ./keyd.nix
    ./man.nix
    ./mozillavpn.nix
    ./network.nix
    ./nix-ld.nix
    ./nix.nix
    ./nvidia.nix
    ./opengl.nix
    ./openssh.nix
    ./power.nix
    ./packages.nix
    ./printing.nix
    ./security.nix
    ./services.nix
    ./shell.nix
    ./steam.nix
    ./syncthing.nix
    ./udisks2.nix
    ./unfree.nix
    ./virtualisation.nix
    ./xdg-portal.nix
  ];
}
