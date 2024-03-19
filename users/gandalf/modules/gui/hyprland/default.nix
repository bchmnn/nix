{ pkgs, lib, nixosConfig, ... }:
let
  common = (import ../common.nix) { pkgs = pkgs; lib = lib; };
in
{
  imports = [
    ../sway/waybar.nix
    ../sway/wofi.nix
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    enableNvidiaPatches = nixosConfig.bchmnn.nvidia.enable;
    # plugins = [ hy3.packages.x86_64-linux.hy3 ];
    settings = {
      "exec-once" = with pkgs; [
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
      "$terminal" = "${pkgs.alacritty}/bin/alacritty";
      "$fileManager" = "${pkgs.gnome.nautilus}/bin/nautilus";
      "$menu" = "${pkgs.wofi}/bin/wofi";
      "$mod" = "SUPER";
      bind = [
        "$mod, Q, killactive,"
        "$mod, return, exec, $terminal"
        "$mod SHIFT, Q, exit,"
        "$mod SHIFT, E, exec, $fileManager"
        "$mod, D, togglefloating,"
        "$mod, space, exec, $menu"
        "$mod CONTROL SHIFT, L, exec, ${pkgs.swaylock-effects}/bin/swaylock --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color ffffff --key-hl-color ${common.colorschemes.default._activeDark} --line-color 00000000 --inside-color 00000088 --inside-ver-color ${common.colorschemes.default._activeDark} --separator-color 00000000 --text-color ${common.colorschemes.default._activeDark} --fade-in 0.1"
        "$mod SHIFT, V, exec, ${pkgs.pavucontrol}/bin/pavucontrol"
        "$mod SHIFT, B, exec, ${pkgs.blueman}/bin/blueman-manager"
        "$mod SHIFT, N, exec, ${pkgs.networkmanagerapplet}/bin/nm-connection-editor"
        "$mod SHIFT, A, exec, ${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw"
        "$mod, period, exec, ${pkgs.emote}/bin/emote"
        # bind = $mod, P, pseudo, # dwindle
        # bind = $mod, J, togglesplit, # dwindle

        # Move focus
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        "$mod, P, focusmonitor, l"
        "$mod, N, focusmonitor, r"

        # Move windows
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, J, movewindow, d"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, L, movewindow, r"

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

        "$mod, W, togglegroup,"

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
