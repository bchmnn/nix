{ pkgs, ... }: {
  home.packages = with pkgs; [
    polybarFull
  ];
  xdg.configFile."polybar/config.ini" = {
    text = ''
      [colors]
      background = #FFFFFF
      background-alt = #D3D3D3
      foreground = #000000
      primary = #F0C674
      secondary = #8ABEB7
      blue = #4276b9
      alert = #A54242
      disabled = #707880

      [bar/main]
      width = 100%
      height = 24pt
      radius = 10

      background = ''${colors.background}
      foreground = ''${colors.foreground}

      line-size = 3pt

      border-size = 4pt
      border-color = #00000000

      padding-left = 0
      padding-right = 1

      module-margin = 1

      separator = 
      separator-foreground = ''${colors.disabled}

      font-0 = DejaVuSansM Nerd Font:pixelsize=12;3

      modules-left = xworkspaces xwindow
      modules-right = systray wlan eth pulseaudio filesystem cpu temperature memory date

      cursor-click = pointer
      cursor-scroll = ns-resize

      enable-ipc = true

      [module/systray]
      type = internal/tray

      format-margin = 8pt
      tray-spacing = 4pt
      tray-size = 55%

      tray-background = ''${colors.blue}
      format-background = ''${colors.blue}
      format-padding = 10px

      format-radius = 5.0

      [module/xworkspaces]
      type = internal/xworkspaces

      label-active = %name%
      label-active-background = ''${colors.background-alt}
      label-active-padding = 1

      label-occupied = %name%
      label-occupied-padding = 1

      label-urgent = %name%
      label-urgent-background = ''${colors.alert}
      label-urgent-padding = 1

      label-empty = %name%
      label-empty-foreground = ''${colors.disabled}
      label-empty-padding = 1

      [module/xwindow]
      type = internal/xwindow
      label = %title:0:60:...%

      [module/filesystem]
      type = internal/fs
      interval = 25

      mount-0 = /home

      label-mounted = %free%
      format-mounted = <label-mounted> 

      [module/pulseaudio]
      type = internal/pulseaudio

      format-volume = <label-volume> <ramp-volume>

      label-volume = %percentage%%
      label-muted = 󰖁
      ramp-volume-0 = 󰕿
      ramp-volume-1 = 󰖀
      ramp-volume-2 = 󰕾

      click-right = pavucontrol

      [module/xkeyboard]
      type = internal/xkeyboard
      blacklist-0 = num lock

      label-layout = %layout%
      label-layout-foreground = ''${colors.primary}

      label-indicator-padding = 2
      label-indicator-margin = 1
      label-indicator-foreground = ''${colors.background}
      label-indicator-background = ''${colors.secondary}

      [module/memory]
      type = internal/memory
      interval = 2
      label = %gb_used:2%
      format = <label> 
      format-margin = 5px

      [module/temperature]
      type = internal/temperature
      internal = 1
      warn-temperature = 80
      format-warn-padding = 10px
      format = <label> <ramp>
      format-warn = <label-warn> <ramp>
      format-warn-background = #eb4d4b
      format-warn-foreground = #ffffff

      ramp-0 = 
      ramp-1 = 
      ramp-2 = 

      [module/cpu]
      type = internal/cpu
      interval = 2
      label = %percentage:2%%
      format = <label> 

      [network-base]
      type = internal/network
      interval = 5
      format-connected = <label-connected>
      format-disconnected = <label-disconnected>

      [module/wlan]
      inherit = network-base
      interface-type = wireless
      label-connected = %signal% 
      label-disconnected = 󰖪

      [module/eth]
      inherit = network-base
      interface-type = wired
      label-connected = eth 󰈁
      label-disconnected = 󰈂

      [module/date]
      type = internal/date
      interval = 1

      date = %a %b %d %H:%M

      label = %date%

      [settings]
      screenchange-reload = true
      pseudo-transparency = true
      ; vim:ft=dosini
    '';
  };
}
