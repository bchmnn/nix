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

    ai = {
      enable = mkEnableOption "ai";
    };

    ratbag = {
      enable = mkEnableOption "ratbag";
    };

  };

  imports = [
    ./audio.nix
    ./ausweisapp.nix
    ./bluetooth.nix
    ./ccache.nix
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
    ./nh.nix
    ./nix-ld.nix
    ./nix.nix
    ./nvidia.nix
    ./ollama.nix
    ./opengl.nix
    ./openssh.nix
    ./openvpn.nix
    ./power.nix
    ./packages.nix
    ./printing.nix
    ./ratbag.nix
    ./rr.nix
    ./security.nix
    ./shell.nix
    ./steam.nix
    ./syncthing.nix
    ./tts.nix
    ./udisks2.nix
    ./virtualisation.nix
    ./xdg-portal.nix
  ];
}
