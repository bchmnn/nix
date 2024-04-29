{ pkgs, lib, config, nixosConfig, ... }:
let

  cfg = config.wayland.windowManager.sway.config;
  common = (import ../common.nix) { pkgs = pkgs; lib = lib; };

in
{

  imports = [
    ./kanshi.nix
    ./swaync
    ./wofi.nix
    ../waybar.nix
  ];

  home.packages = with pkgs; [
    brightnessctl # this program allows you read and control device brightness
    pavucontrol # pulseaudio volume control
    playerctl # command-line utility and library for controlling media players that implement mpris
    networkmanagerapplet # networkmanager control applet for gnome
    udiskie # removable disk automounter for udisks
    dracula-theme # dracula variant of the ant theme
    gnome3.adwaita-icon-theme
    wl-clipboard # command-line copy/paste utilities for wayland
    sway-contrib.grimshot # a helper for screenshots within sway
    wdisplays # a graphical application for configuring displays in wayland compositors
    wlr-randr # an xrandr clone for wlroots compositors
    kanshi # dynamic display configuration tool
    nextcloud-client # nextcloud themed desktop client
    libsForQt5.kdeconnect-kde # kde connect provides several features to integrate your phone and your computer
    system-config-printer # graphical user interface for cups administration
    emote # modern emoji picker for linux
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
    extraSessionCommands = with lib; with nixosConfig.bchmnn; ''
      export CLUTTER_BACKEND=wayland;
      export GDK_BACKEND=wayland;
      export GDK_DPI_SCALE=1;
      export NIXOS_OZONE_WL=1;
      export MOZ_ENABLE_WAYLAND=1;
      export MOZ_USE_XINPUT2=1;
      export XDG_SESSION_TYPE=wayland;
      export XDG_CURRENT_DESKTOP=sway;

      # sdl
      export SDL_VIDEODRIVER=wayland

      # qt
      export QT_QPA_PLATFORM=wayland-egl
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

      # java
      export _JAVA_AWT_WM_NONREPARENTING=1
      export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on";

    '' + optionalString nvidia.enable ''
      # nvidia
      export WLR_RENDERER=vulkan;
      # export LIBVA_DRIVER_NAME,nvidia;
      # export GBM_BACKEND=nvidia-drm;
      export __GL_GSYNC_ALLOWED=0;
      export __GL_VRR_ALLOWED=0;
      export __GLX_VENDOR_LIBRARY_NAME=nvidia;
      export WLR_NO_HARDWARE_CURSORS=1;

      # xwayland compat
      export XWAYLAND_NO_GLAMOR=1;
    '';
    config = {
      modifier = "Mod4";
      terminal = "${pkgs.alacritty}/bin/alacritty";
      menu = "${pkgs.wofi}/bin/wofi";
      # TODO for some reason bar only works when used with exec
      bars = [];
      startup = with pkgs; [
        # TODO activate with systemd prbly requires a graphical.target?
        # { command = "${nixosConfig.systemd.package}/bin/systemctl --user import-environment XDG_SESSION_TYPE XDG_CURRENT_DESKTOP"; }
        # { command = "${dbus}/bin/dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway"; }
        # { command = "${nixosConfig.systemd.package}/bin/systemctl --user stop xdg-desktop-portal xdg-desktop-portal-wlr"; }
        # { command = "${nixosConfig.systemd.package}/bin/systemctl --user start xdg-desktop-portal xdg-desktop-portal-wlr"; }
        # { command = "${dbus}/bin/dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK"; }
        { command = "${config.programs.waybar.package}/bin/waybar -c ${config.xdg.configHome}/waybar/swaybar.json -s ${config.xdg.configHome}/waybar/swaybar.css"; }
        { command = "${dbus}/bin/dbus-update-activation-environment --all"; }
        { command = "${kanshi}/bin/kanshi"; }
        { command = "${networkmanagerapplet}/bin/nm-applet"; }
        { command = "${blueman}/bin/blueman-applet"; }
        { command = "${udiskie}/bin/udiskie --tray"; }
        { command = "${swaynotificationcenter}/bin/swaync"; }
        { command = "${nextcloud-client}/bin/nextcloud"; }
        { command = "${plasma5Packages.kdeconnect-kde}/bin/kdeconnect-indicator"; }
        { command = "${system-config-printer}/bin/system-config-printer-applet"; }
        { command = "${emote}/bin/emote"; }
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
        "*".bg = "${common.wallpaper.default} fill";
      };
      left = "h";
      down = "j";
      up = "k";
      right = "l";

      keybindings = {
        "${cfg.modifier}+Ctrl+Shift+l" = "exec ${pkgs.swaylock-effects}/bin/swaylock --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color ffffff --key-hl-color ${common.colorschemes.default._black} --line-color 00000000 --inside-color 00000088 --inside-ver-color ${common.colorschemes.default._white} --separator-color 00000000 --text-color ${common.colorschemes.default._white} --fade-in 0.1";

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

        "${cfg.modifier}+p" = "focus output left";
        "${cfg.modifier}+n" = "focus output right";

        # Moving
        "${cfg.modifier}+Shift+${cfg.left}" = "move left";
        "${cfg.modifier}+Shift+${cfg.down}" = "move down";
        "${cfg.modifier}+Shift+${cfg.up}" = "move up";
        "${cfg.modifier}+Shift+${cfg.right}" = "move right";

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
        "${cfg.modifier}+period" = "exec ${pkgs.emote}/bin/emote";
      };
      fonts = {
        names = [ common.font ];
        style = "Bold";
        size = 12.0;
      };
      seat = {
        "*" = {
          xcursor_theme = "macOS-Monterey 32";
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
      for_window [app_id="com.nextcloud.desktopclient.nextcloud" title="Nextcloud"] {
        floating enable
        resize set 700px 450px
        move position 100ppt 0
        move left 700px
      }
      for_window [title="Extension: \(Gopass Bridge\) - gopass bridge — Mozilla Firefox"] {
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
      bindsym ${cfg.modifier}+Escape exec swaymsg '[app_id="$ddterm-id"] scratchpad show' || $ddterm && sleep .1 && swaymsg '[app_id="$ddterm-id"] $ddterm-resize'
      # ^-- resize again, case moving to different output

      workspace 1
    '';
  };

}

