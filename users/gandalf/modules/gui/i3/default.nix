{ pkgs, lib, config, ... }:
let

  cfg = config.xsession.windowManager.i3.config;
  # common = (import ../common.nix) { pkgs = pkgs; lib = lib; };
  common = (import ../common.nix) { inherit pkgs; inherit lib; };

in {

  imports = [
    ./autorandr.nix
  ];

  home.packages = with pkgs; [
    alacritty
    dmenu
    wireplumber
    feh # lightweight image viewer (also sets wallpaper)
    brightnessctl # control screen brightness
    pavucontrol # control audio
    playerctl # control player
    networkmanagerapplet # control network
    blueman # control bluetooth
    nextcloud-client # nextcloud client to connect to any instance
    plasma5Packages.kdeconnect-kde # sync phone and pc
  ];

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "${pkgs.alacritty}/bin/alacritty";
      menu = "${pkgs.dmenu}/bin/dmenu_run";
      startup = with pkgs; [
        { command = "${feh}/bin/feh --bg-fill ${common.wallpaper}"; }
        { command = "${networkmanagerapplet}/bin/nm-applet"; }
        { command = "${blueman}/bin/blueman-applet"; }
        { command = "${nextcloud-client}/bin/nextcloud"; }
        { command = "${plasma5Packages.kdeconnect-kde}/bin/kdeconnect-indicator"; }
      ];
      fonts = {
        names = [ common.font ];
        style = "Bold";
        size = 12.0;
      };
      window = {
        titlebar = false;
        border = 4;
      };
      gaps = {
        inner = 5;
      };
      colors = {
        focused = {
          border = common.colorschemes.default.active;
          background = common.colorschemes.default.active;
          text = common.colorschemes.default.black;
          indicator = common.colorschemes.default.activeDark;
          childBorder = common.colorschemes.default.active;
        };
        focusedInactive = {
          border = common.colorschemes.default.inactive;
          background = common.colorschemes.default.inactive;
          text = common.colorschemes.default.white;
          indicator = common.colorschemes.default.inactive;
          childBorder = common.colorschemes.default.inactive;
        };
        unfocused = {
          border = common.colorschemes.default.inactiveDark;
          background = common.colorschemes.default.inactiveDark;
          text = common.colorschemes.default.white;
          indicator = common.colorschemes.default.inactiveDark;
          childBorder = common.colorschemes.default.inactiveDark;
        };
        urgent = {
          border = common.colorschemes.default.alert;
          background = common.colorschemes.default.alert;
          text = common.colorschemes.default.white;
          indicator = common.colorschemes.default.black;
          childBorder = common.colorschemes.default.alert;
        };
        placeholder = {
          border = common.colorschemes.default.active;
          background = common.colorschemes.default.active;
          text = common.colorschemes.default.black;
          indicator = common.colorschemes.default.activeDark;
          childBorder = common.colorschemes.default.active;
        };
      };
      keybindings = {
        # Basics
        "${cfg.modifier}+Return" = "exec ${cfg.terminal}";
        "${cfg.modifier}+q" = "kill";
        "${cfg.modifier}+i" = "exec ${cfg.menu}";
        "${cfg.modifier}+space" = "exec ${cfg.menu}";
        "${cfg.modifier}+Shift+c" = "reload";
        "${cfg.modifier}+Shift+q" = "exec i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes' 'i3-msg exit'";
        "${cfg.modifier}+Shift+r" = "restart";

        # Focus
        "${cfg.modifier}+h" = "focus left";
        "${cfg.modifier}+j" = "focus down";
        "${cfg.modifier}+k" = "focus up";
        "${cfg.modifier}+l" = "focus right";

        "${cfg.modifier}+p" = "focus output left";
        "${cfg.modifier}+n" = "focus output right";

        # Moving
        "${cfg.modifier}+Shift+h" = "move left";
        "${cfg.modifier}+Shift+j" = "move down";
        "${cfg.modifier}+Shift+k" = "move up";
        "${cfg.modifier}+Shift+l" = "move right";

        # Workspaces
        "${cfg.modifier}+1" = "workspace number 1";
        "${cfg.modifier}+2" = "workspace number 2";
        "${cfg.modifier}+3" = "workspace number 3";
        "${cfg.modifier}+4" = "workspace number 4";
        "${cfg.modifier}+5" = "workspace number 5";
        "${cfg.modifier}+6" = "workspace number 6";
        "${cfg.modifier}+7" = "workspace number 7";
        "${cfg.modifier}+8" = "workspace number 8";
        "${cfg.modifier}+9" = "workspace number 9";
        "${cfg.modifier}+0" = "workspace number 10";

        "${cfg.modifier}+Shift+1" = "move container to workspace number 1";
        "${cfg.modifier}+Shift+2" = "move container to workspace number 2";
        "${cfg.modifier}+Shift+3" = "move container to workspace number 3";
        "${cfg.modifier}+Shift+4" = "move container to workspace number 4";
        "${cfg.modifier}+Shift+5" = "move container to workspace number 5";
        "${cfg.modifier}+Shift+6" = "move container to workspace number 6";
        "${cfg.modifier}+Shift+7" = "move container to workspace number 7";
        "${cfg.modifier}+Shift+8" = "move container to workspace number 8";
        "${cfg.modifier}+Shift+9" = "move container to workspace number 9";
        "${cfg.modifier}+Shift+0" = "move container to workspace number 10";

        "${cfg.modifier}+Control+j" = "workspace prev";
        "${cfg.modifier}+Control+k" = "workspace next";
        "${cfg.modifier}+Control+Shift+j" = "move workspace to output left";
        "${cfg.modifier}+Control+Shift+k" = "move workspace to output right";

        # Splits
        "${cfg.modifier}+b" = "split h";
        "${cfg.modifier}+v" = "split v";

        # Layouts
        "${cfg.modifier}+s" = "layout stacking";
        "${cfg.modifier}+w" = "layout tabbed";
        "${cfg.modifier}+e" = "layout toggle split";
        "${cfg.modifier}+f" = "fullscreen toggle";

        "${cfg.modifier}+a" = "focus parent";

        "${cfg.modifier}+d" = "floating toggle";
        "${cfg.modifier}+Shift+d" = "focus mode_toggle";

        # Scratchpad
        "${cfg.modifier}+Shift+minus" = "move scratchpad";
        "${cfg.modifier}+minus" = "scratchpad show";

        # Resize mode
        "${cfg.modifier}+r" = "mode resize";

        # Multimedia Keys
        "XF86AudioRaiseVolume" = "exec ${pkgs.wireplumber}/bin/wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "exec ${pkgs.wireplumber}/bin/wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute" = "exec ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86AudioMicMute" = "exec ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

        "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl -q set 5%-";
        "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl -q set 5%+";

        "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";
        "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
        "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
        "XF86AudioPause" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";

        # Programs
        "${cfg.modifier}+Shift+v" = "exec ${pkgs.pavucontrol}/bin/pavucontrol";
        "${cfg.modifier}+Shift+b" = "exec ${pkgs.blueman}/bin/blueman-manager";
        "${cfg.modifier}+Shift+n" = "exec ${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
        "${cfg.modifier}+Shift+a" = "exec ${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
      };
    };
  };
}
