{ pkgs, lib, nixosConfig, hy3, ... }:
let
  common = (import ../common.nix) { pkgs = pkgs; lib = lib; };

  dropterm = rec {
    class = "alacritty-dropterm";
    name = "toggle-${class}";
    package = pkgs.writeShellScriptBin name ''
      TOGGLE=/tmp/${class}
      WINDOW=$(${pkgs.hyprland}/bin/hyprctl -j clients | ${pkgs.jq}/bin/jq 'any(.[]; .class == "${class}")')
      if [ -f "$TOGGLE" ]; then
        if [ $WINDOW == "true" ]; then
          ${pkgs.hyprland}/bin/hyprctl --batch \
            "dispatch movewindowpixel 0 -700,${class}; dispatch pin ${class}; dispatch cyclenext"
          rm $TOGGLE
        else 
          ${pkgs.alacritty}/bin/alacritty --class=${class} & disown
        fi
      else
        if [ $WINDOW == "true" ]; then
          ${pkgs.hyprland}/bin/hyprctl --batch \
            "dispatch movewindowpixel 0 700,${class}; dispatch pin ${class}; dispatch focuswindow ${class}"
        else
          ${pkgs.alacritty}/bin/alacritty --class=${class} & disown
        fi
        touch $TOGGLE
      fi
    '';
    bin = "${package}/bin/${name}";
  };

in
{
  imports = [
    ../sway/waybar.nix
    ../sway/wofi.nix
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
    # package = pkgs.swaylock-effects;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [ hy3.packages.x86_64-linux.hy3 ];
    settings = {
      env = with lib; with nixosConfig.bchmnn; optionals nvidia.enable [
        "CLUTTER_BACKEND,wayland"
        "GDK_BACKEND,wayland"
        "GDK_DPI_SCALE,1"
        "NIXOS_OZONE_WL,1"
        "MOZ_ENABLE_WAYLAND,1"
        "MOZ_USE_XINPUT2,1"
        "XDG_SESSION_TYPE,wayland"

        # nvidia
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "WLR_NO_HARDWARE_CURSORS,1"

        # sdl
        "SDL_VIDEODRIVER,wayland"

        # qt
        "QT_QPA_PLATFORM,wayland-egl"
        # "QT_QPA_PLATFORM,wayland"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"

        # java
        "_JAVA_AWT_WM_NONREPARENTING,1"
        "_JAVA_OPTIONS,\"-Dawt.useSystemAAFontSettings=on\""
      ];
      "exec-once" = with pkgs; [
        "${swaybg}/bin/swaybg -m fill -i ${common.wallpaper}"
        "${waybar}/bin/waybar"
        "${dbus}/bin/dbus-update-activation-environment --all"
        "${kanshi}/bin/kanshi"
        "${networkmanagerapplet}/bin/nm-applet"
        "${blueman}/bin/blueman-applet"
        "${udiskie}/bin/udiskie --tray"
        "${swaynotificationcenter}/bin/swaync"
        "${nextcloud-client}/bin/nextcloud"
        "${plasma5Packages.kdeconnect-kde}/bin/kdeconnect-indicator"
        "${system-config-printer}/bin/system-config-printer-applet"
        "${emote}/bin/emote"
      ];
      input = {
        accel_profile = "flat";
        touchpad = {
          natural_scroll = "true";
          scroll_factor = "0.5";
        };
      };
      general = {
        layout = "hy3";
        border_size = "2";
        gaps_out = "5";
        gaps_in = "5";
      };
      decoration = {
        rounding = "5";
        drop_shadow = "true";
        shadow_range = "10";
        shadow_render_power = "3"; # int [1-4]
        shadow_offset = "0 5"; # vec2 [0, 0]
        shadow_scale = "0.5"; # float [0.0-1.0]
        "col.shadow" = "rgba(00000099)";
      };
      plugin = {
        hy3 = {
          tabs = {
            height = 20;
            text_font = common.font;
            text_height = 12;
            "col.active" = "0xffffdeeb"; # common.colorschemes.default.active;
            "col.urgent" = "0xffc92a2a"; # common.colorschemes.default.alert;
            "col.inactive" = "0xff212529"; # common.colorschemes.default.inactiveDark;
            "col.text.active" = "0xff000000"; # common.colorschemes.default.black;
            "col.text.urgent" = "0xffffffff"; # common.colorschemes.default.white;
            "col.text.inactive" = "0xffffffff"; # common.colorschemes.default.white;
          };
        };
      };
      "$terminal" = "${pkgs.alacritty}/bin/alacritty";
      "$fileManager" = "${pkgs.gnome.nautilus}/bin/nautilus";
      "$menu" = "${pkgs.wofi}/bin/wofi";
      "$mod" = "SUPER";
      windowrule = [
        "float, ${dropterm.class}"
        "size 96% 33%, ${dropterm.class}"
        "move 2% 50, ${dropterm.class}"
      ];
      bind = [
        "$mod, grave, exec, ${dropterm.bin}"
        "$mod, escape, exec, ${dropterm.bin}"
        "$mod, Q, killactive,"
        "$mod, return, exec, $terminal"
        "$mod SHIFT, Q, exit,"
        "$mod SHIFT, E, exec, $fileManager"
        "$mod, F, fullscreen,"
        "$mod, D, togglefloating,"
        "$mod, space, exec, $menu"
        "$mod CONTROL SHIFT, L, exec, ${pkgs.swaylock-effects}/bin/swaylock --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color ffffff --key-hl-color ${common.colorschemes.default._activeDark} --line-color 00000000 --inside-color 00000088 --inside-ver-color ${common.colorschemes.default._activeDark} --separator-color 00000000 --text-color ${common.colorschemes.default._activeDark} --fade-in 0.1"
        "$mod SHIFT, V, exec, ${pkgs.pavucontrol}/bin/pavucontrol"
        "$mod SHIFT, B, exec, ${pkgs.blueman}/bin/blueman-manager"
        "$mod SHIFT, N, exec, ${pkgs.networkmanagerapplet}/bin/nm-connection-editor"
        "$mod SHIFT, A, exec, ${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw"
        "$mod, period, exec, ${pkgs.emote}/bin/emote"

        # Move focus
        "$mod, H, hy3:movefocus, l"
        "$mod, L, hy3:movefocus, r"
        "$mod, K, hy3:movefocus, u"
        "$mod, J, hy3:movefocus, d"

        "$mod, P, focusmonitor, l"
        "$mod, N, focusmonitor, r"

        # Move windows
        "$mod SHIFT, H, hy3:movewindow, l"
        "$mod SHIFT, J, hy3:movewindow, d"
        "$mod SHIFT, K, hy3:movewindow, u"
        "$mod SHIFT, L, hy3:movewindow, r"

        # Switch workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move active window to a workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        "$mod CONTROL, J, workspace, -1"
        "$mod CONTROL, K, workspace, +1"

        "$mod CONTROL SHIFT, J, movecurrentworkspacetomonitor, l"
        "$mod CONTROL SHIFT, K, movecurrentworkspacetomonitor, r"

        "$mod, W, hy3:changegroup, toggletab"

        "$mod, B, hy3:makegroup, h"
        "$mod, V, hy3:makegroup, v"

        ", print, exec, ${pkgs.sway-contrib.grimshot}/bin/grimshot copy area"
      ];
      binde = [
        ", XF86AudioRaiseVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl -q set 5%-"
        ", XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl -q set 5%+"
        ", XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"
        ", XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
        ", XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
        ", XF86AudioPause, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
      ];
      bindm = [
        # mouse movements
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];
    };
    systemd = {
      enable = true;
      # extraCommands = []
    };
    xwayland.enable = true;
  };
}
