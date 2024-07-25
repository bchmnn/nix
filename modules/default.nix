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
        example = [ "sway" "i3" ];
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

    sync = {
      enable = mkEnableOption "sync";
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

    ai = {
      enable = mkEnableOption "ai";
    };

    ratbag = {
      enable = mkEnableOption "ratbag";
    };

  };

  imports = [
    ./arr.nix
    ./audio.nix
    ./ausweisapp.nix
    ./bluetooth.nix
    ./ccache.nix
    ./desktop.nix
    ./dbus.nix
    ./fonts.nix
    ./gstreamer.nix
    ./i18n.nix
    ./kdeconnect.nix
    ./keyd.nix
    ./man.nix
    ./nautilus.nix
    ./network.nix
    ./nh.nix
    ./nix-ld.nix
    ./nix.nix
    ./nvidia.nix
    ./ollama.nix
    ./opengl.nix
    ./openssh.nix
    ./power.nix
    ./packages.nix
    ./printing.nix
    ./ratbag.nix
    ./security.nix
    ./shell.nix
    ./steam.nix
    ./syncthing.nix
    ./tts.nix
    ./udisks2.nix
    ./virtualisation.nix
    ./vpn.nix
    ./wine.nix
    ./xdg-portal.nix
  ];
}
