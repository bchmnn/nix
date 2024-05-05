{ lib, pkgs, config, ... }: with config.bchmnn; lib.mkIf (gui.enable && gui.flavour != [ ]) {

  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw

  programs.sway.enable = builtins.elem "sway" gui.flavour;
  services.xserver.windowManager.i3.enable = builtins.elem "i3" gui.flavour;

  services.xserver = {
    enable = (builtins.elem "i3" gui.flavour || builtins.elem "gnome" gui.flavour);
    libinput.enable = true;
    desktopManager.gnome.enable = builtins.elem "gnome" gui.flavour;
    displayManager = {
      gdm.enable = builtins.elem "gnome" gui.flavour;
      startx.enable = builtins.elem "i3" gui.flavour;
    };
  };

  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "sway-run" ''
      export WLR_NO_HARDWARE_CURSORS=1
      exec ${sway}/bin/sway "$@"
    '')
  ];

  environment = {
    etc = {
      "greetd/environments".text = (lib.strings.concatLines gui.flavour);
      "greetd/kanshi-config".text = ''
        profile nomad {
          output "LVDS-1" enable
        }
        profile iroh {
          output "DP-3" enable mode 2560x1440 position 0,0
          output "DP-2" enable mode 2560x1440 position 2560,0
          output "DP-1" enable mode 2560x1440 position 5120,0
        }
        profile station {
          output "LVDS-1" disable
          output "Dell Inc. DELL U2515H 9X2VY5490XUL" enable mode 1920x1080 position 0,0
          output "Dell Inc. DELL U2515H 9X2VY5C7138L" enable mode 1920x1080 position 1920,0
          output "HJW VGA TO HDMI 0x00000100" enable mode 1920x1080 position 3840,0
        }
      '';
      "greetd/sway-config".text = ''
        exec "${pkgs.kanshi}/bin/kanshi --config /etc/greetd/kanshi-config"
        exec "${pkgs.greetd.gtkgreet}/bin/gtkgreet -l; swaymsg exit"

        bindsym Mod4+shift+e exec swaynag \
          -t warning \
          -m 'What do you want to do?' \
          -b 'Poweroff' 'systemctl poweroff' \
          -b 'Reboot' 'systemctl reboot'

        include /etc/sway/config.d/*
      '';
    };
  };

  services.greetd = {
    enable = gui.greeter.enable;
    settings = {
      default_session = {
        command = "sway-run --config /etc/greetd/sway-config" + lib.optionalString nvidia.enable " --unsupported-gpu";
      };
    };
  };

}
