{ lib, ... }: {

  # options affecting multiple modules
  options.bchmnn = with lib; {

    power = {
      tlp = {
        settings = mkOption {
          type = with types; attrsOf (oneOf [ bool int float str (listOf str) ]);
          default = {
            # performance | powersave
            CPU_SCALING_GOVERNOR_ON_AC = "performance";
            CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
            # performance | balance_performance | default | balance_power | power
            CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
            CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
            # performance | balanced | low-power
            PLATFORM_PROFILE_ON_AC = "performance";
            PLATFORM_PROFILE_ON_BAT = "low-power";
            CPU_MIN_PERF_ON_AC = 0;
            CPU_MAX_PERF_ON_AC = 100;
            CPU_MIN_PERF_ON_BAT = 0;
            CPU_MAX_PERF_ON_BAT = 100;
          };
        };
      };
    };


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
      pipewire-wine-fix = {
        enable = mkEnableOption "pipewire-wine-fix";
      };
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
    ./memtest86.nix
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
