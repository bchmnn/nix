{ config, pkgs, lib, ... }:
let

  cfg = config.wayland.windowManager.sway.config;
  common = import ./common.nix;

  wallpaper = pkgs.fetchurl {
    url = "https://live.staticflickr.com/65535/52797919139_2444712a38_o_d.png";
    sha256 = "1a9148d8911fa25afa82d3b843ee620173955a7ca705d525f3e9d00e00696308";
    meta.licenses = lib.licenses.cc0;
  };

  # flameshot = pkgs.libsForQt5.callPackage ./flameshot/build.nix { };

in
{

  home.packages = with pkgs; [
    brightnessctl # control screen brightness
    pavucontrol # control audio
    playerctl # control player
    networkmanagerapplet # control network
    dracula-theme # gtk theme
    gnome3.adwaita-icon-theme # default gnome cursors
    wl-clipboard # cli tool to manage wayland clipboard
    sway-contrib.grimshot
    wdisplays
    wlr-randr
  ];

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
  };

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures = {
      base = true;
      gtk = true;
    };
    xwayland = true;
    extraSessionCommands = ''
      export CLUTTER_BACKEND=wayland;
      export GDK_BACKEND=wayland;
      export GDK_DPI_SCALE=1;
      export NIXOS_OZONE_WL=1;
      export WLR_NO_HARDWARE_CURSORS=1;
      export MOZ_ENABLE_WAYLAND=1;
      export MOZ_USE_XINPUT2=1;
      export XDG_SESSION_TYPE=wayland;
      export XDG_CURRENT_DESKTOP=sway;
      # SDL:
      export SDL_VIDEODRIVER=wayland
      # QT (needs qt5.qtwayland in systemPackages):
      export QT_QPA_PLATFORM=wayland-egl
      # export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
      # Fix for some Java AWT applications (e.g. Android Studio),
      # use this if they aren't displayed properly:
      export _JAVA_AWT_WM_NONREPARENTING=1
      export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on";
    '';
    config = {
      modifier = "Mod4";
      terminal = "${pkgs.alacritty}/bin/alacritty";
      menu = "${pkgs.wofi}/bin/wofi";
      startup = [
        { command = "blueman-applet"; }
        { command = "nm-applet"; }
        { command = "swaync"; }
      ];
      input = {
        "2:7:SynPS/2_Synaptics_TouchPad" = {
          accel_profile = "flat";
          dwt = "enabled";
          dwtp = "enabled";
          tap = "enabled";
          natural_scroll = "enabled";
          middle_emulation = "enabled";
          scroll_factor = "0.3";
        };
        "2:10:TPPS/2_IBM_TrackPoint" = {
          accel_profile = "flat";
          scroll_factor = "0.5";
        };
      };
      output = {
        "*".bg = "${wallpaper} fill";
      };
      left = "h";
      down = "j";
      up = "k";
      right = "l";

      keybindings = {
        "${cfg.modifier}+Ctrl+Shift+l" = "exec ${pkgs.swaylock-effects}/bin/swaylock --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color ffffff --key-hl-color ${common.colorschemes.default._activeDark} --line-color 00000000 --inside-color 00000088 --inside-ver-color ${common.colorschemes.default._activeDark} --separator-color 00000000 --text-color ${common.colorschemes.default._activeDark} --fade-in 0.1";

        # Basics
        "${cfg.modifier}+Return" = "exec ${cfg.terminal}";
        "${cfg.modifier}+q" = "kill";
        "${cfg.modifier}+Space" = "exec ${cfg.menu}";
        "${cfg.modifier}+Shift+c" = "reload";
        "${cfg.modifier}+Shift+q" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

        # Focus
        "${cfg.modifier}+${cfg.left}" = "focus left";
        "${cfg.modifier}+${cfg.down}" = "focus down";
        "${cfg.modifier}+${cfg.up}" = "focus up";
        "${cfg.modifier}+${cfg.right}" = "focus right";

        "${cfg.modifier}+Left" = "focus left";
        "${cfg.modifier}+Down" = "focus down";
        "${cfg.modifier}+Up" = "focus up";
        "${cfg.modifier}+Right" = "focus right";

        # Moving
        "${cfg.modifier}+Shift+${cfg.left}" = "move left";
        "${cfg.modifier}+Shift+${cfg.down}" = "move down";
        "${cfg.modifier}+Shift+${cfg.up}" = "move up";
        "${cfg.modifier}+Shift+${cfg.right}" = "move right";

        "${cfg.modifier}+Shift+Left" = "move left";
        "${cfg.modifier}+Shift+Down" = "move down";
        "${cfg.modifier}+Shift+Up" = "move up";
        "${cfg.modifier}+Shift+Right" = "move right";

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

        "${cfg.modifier}+Control+${cfg.down}" = "workspace prev";
        "${cfg.modifier}+Control+${cfg.up}" = "workspace next";
        "${cfg.modifier}+Control+Shift+${cfg.down}" = "move workspace to output left";
        "${cfg.modifier}+Control+Shift+${cfg.up}" = "move workspace to output right";

        # Splits
        "${cfg.modifier}+b" = "splith";
        "${cfg.modifier}+v" = "splitv";

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

        # Screenshot
        "Print" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy area";

        # Programs
        "${cfg.modifier}+Shift+v" = "exec ${pkgs.pavucontrol}/bin/pavucontrol";
        "${cfg.modifier}+Shift+b" = "exec ${pkgs.blueman}/bin/blueman-manager";
        "${cfg.modifier}+Shift+n" = "exec ${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
        "${cfg.modifier}+Shift+a" = "exec ${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
      };
      fonts = {
        names = [ common.font ];
        style = "Bold";
        size = 12.0;
      };
      seat = {
        "*" = {
          xcursor_theme = common.gtk;
        };
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
      bars = [
        {
          command = "${pkgs.waybar}/bin/waybar";
        }
      ];
    };
    extraConfig = ''
      for_window [title="Firefox — Sharing Indicator"] {
        floating enable
      }
      for_window [title="Bluetooth Devices"] {
        floating enable
        resize set 700px 450px
        move position 100ppt 0
        move left 700px
      }
      for_window [title="Volume Control"] {
        floating enable
        resize set 700px 450px
        move position 100ppt 0
        move left 700px
      }
      for_window [app_id="nm-connection-editor" title="Network Connections"] {
        floating enable
        resize set 700px 450px
        move position 100ppt 0
        move left 700px
      }
      for_window [app_id="thunderbird" title="Reminder"] {
        floating enable
        resize set 700px 450px
        move position 100ppt 0
        move left 700px
      }

      set $ddterm-id dropdown-terminal
      set $ddterm ${cfg.terminal} --class $ddterm-id
      set $ddterm-resize resize set 100ppt 40ppt, move position 0 0

      # resize/move new dropdown terminal windows
      for_window [app_id="$ddterm-id"] {
        floating enable
        $ddterm-resize
        move to scratchpad
        scratchpad show
      }

      # show existing or start new dropdown terminal
      bindsym ${cfg.modifier}+grave exec swaymsg '[app_id="$ddterm-id"] scratchpad show' || $ddterm && sleep .1 && swaymsg '[app_id="$ddterm-id"] $ddterm-resize'
      # ^-- resize again, case moving to different output
    '';
  };

}

