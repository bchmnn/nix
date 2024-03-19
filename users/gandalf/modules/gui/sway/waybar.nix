{ pkgs, ... }: {
  programs.waybar = {
    enable = true;

    settings.mainBar = {
      layer = "top";
      margin = "5 5 5 5";
      modules-left = [ "sway/workspaces" "sway/window" "sway/mode"
        # "hyprland/workspaces" "hyprland/window"
      ];
      modules-center = [ "clock" ];
      modules-right = [ "tray" "network" "pulseaudio" "custom/mem" "temperature" "backlight" "battery" ];
      "sway/workspaces" = {
        disable-scroll = true;
        persistent-workspaces = {
          "1" = [ ];
          "2" = [ ];
          "3" = [ ];
          "4" = [ ];
        };
      };
      "sway/window" = {
        format = "{title}";
        max-length = 43;
      };
      "sway/mode" = {
        format = "<span style=\"italic\">{}</span>";
      };
      "hyprland/workspaces" = {
        disable-scroll = true;
      };
      "hyprland/window" = {
        format = "{title}";
      };
      clock = {
        timezones = [ "Europe/Berlin" ];
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        format = "{:%a, %d %b, %H:%M}";
        actions = {
          on-click = "tz_up";
        };
      };
      network = {
        interval = 1;
        format = "{ifname}";
        format-wifi = "{signalStrength}% ";
        format-ethernet = "eth 󰈁";
        format-disconnected = "󰈂"; # An empty format will hide the module.
        tooltip-format = "{ifname} via {gwaddr} 󰈁";
        tooltip-format-wifi = "{essid} ({signalStrength}%) ";
        tooltip-format-ethernet = "{ifname} ";
        tooltip-format-disconnected = "Disconnected";
      };
      pulseaudio = {
        reverse-scrolling = 1;
        format = "{volume}% {icon} {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = "󰖁 {icon} {format_source}";
        format-muted = "󰖁 {format_source}";
        format-source = "{volume}% ";
        format-source-muted = "";
        format-icons = {
          headphone = "";
          hands-free = "󰋎";
          headset = "󰋎";
          phone = "";
          portable = "";
          car = "";
          default = [
            "󰕿"
            "󰖀"
            "󰕾"
          ];
        };
        on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
        min-length = 13;
      };
      "custom/mem" = {
        format = "{} 󰍛";
        interval = 3;
        exec = "free -h | awk '/Mem:/{printf $3}'";
        tooltip = false;
      };
      temperature = {
        critical-threshold = 80;
        format = "{temperatureC}°C {icon}";
        format-icons = [
          ""
          ""
          ""
          ""
          ""
        ];
        tooltip = false;
      };
      backlight = {
        device = "intel_backlight";
        format = "{percent}% {icon}";
        format-icons = [
          "󰌶"
          "󱩎"
          "󱩏"
          "󱩐"
          "󱩑"
          "󱩒"
          "󱩓"
          "󱩔"
          "󱩕"
          "󱩖"
          "󰛨"
        ];
      };
      battery = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{capacity}% {icon}";
        format-charging = "{capacity}% 󰂄";
        format-plugged = "{capacity}% ";
        format-alt = "{time} {icon}";
        format-icons = [
          "󰂃"
          "󰁺"
          "󰁻"
          "󰁼"
          "󰁽"
          "󰁾"
          "󰁿"
          "󰂀"
          "󰂁"
          "󰂂"
          "󰁹"
        ];
        on-update = pkgs.writeShellScript "check-battery" ''
          bat=/sys/class/power_supply/BAT0
          CRIT=''${1:-15}

          FILE=~/.config/waybar/.notified.target

          stat=$(cat $bat/status)
          perc=$(cat $bat/capacity)

          if [[ $perc -le $CRIT ]] && [[ $stat == "Discharging" ]]; then
            if [[ ! -f "$FILE" ]]; then
              notify-send --urgency=critical --icon=dialog-warning "Battery Low" "Current charge: $perc%"
              touch $FILE
            fi
          elif [[ -f "$FILE" ]]; then
            rm $FILE
          fi
        '';
      };
      tray = {
        icon-size = 16;
        spacing = 0;
      };
    };
    style = ''
      @define-color bg-color #212529;

      * {
          border: none;
          border-radius: 0;
          font-family: DejaVuSansM Nerd Font;
          min-height: 20px;
      }

      window#waybar {
          background: transparent;
      }

      window#waybar.hidden {
          opacity: 0.2;
      }

      #workspaces {
          padding-left: 8px;
          padding-right: 8px;
          margin-right: 8px;
          border-radius: 10px;
          transition: none;
          background: @bg-color;
      }

      #workspaces button {
          transition: none;
          color: #7c818c;
          background: transparent;
          padding: 5px;
          font-size: 18px;
      }

      #workspaces button.persistent {
          color: #7c818c;
          font-size: 12px;
      }

      #workspaces button:hover {
          transition: none;
          box-shadow: inherit;
          text-shadow: inherit;
          border-radius: inherit;
          color: @bg-color;
          background: #7c818c;
      }

      #workspaces button.focused {
          color: white;
      }

      #workspaces button.visible {
          color: white;
      }

      #window {
          padding-left: 16px;
          padding-right: 16px;
          margin-right: 8px;
          border-radius: 10px 10px 10px 10px;
          transition: none;
          color: #ffffff;
          background: @bg-color;
      }

      #mode {
          padding-left: 16px;
          padding-right: 16px;
          border-radius: 10px;
          transition: none;
          color: #ffffff;
          background: @bg-color;
      }

      #clock {
          padding-left: 16px;
          padding-right: 16px;
          border-radius: 10px 10px 10px 10px;
          transition: none;
          color: #ffffff;
          background: @bg-color;
      }

      #network {
          margin-right: 8px;
          padding-left: 16px;
          padding-right: 16px;
          border-radius: 10px;
          transition: none;
          color: #ffffff;
          background: @bg-color;
      }

      #pulseaudio {
          margin-right: 8px;
          padding-left: 16px;
          padding-right: 16px;
          border-radius: 10px;
          transition: none;
          color: #ffffff;
          background: @bg-color;
      }

      #pulseaudio.muted {
          background-color: #90b1b1;
          color: #2a5c45;
      }

      #custom-mem {
          margin-right: 8px;
          padding-left: 16px;
          padding-right: 16px;
          border-radius: 10px;
          transition: none;
          color: #ffffff;
          background: @bg-color;
      }

      #temperature {
          margin-right: 8px;
          padding-left: 16px;
          padding-right: 16px;
          border-radius: 10px;
          transition: none;
          color: #ffffff;
          background: @bg-color;
      }

      #temperature.critical {
          background-color: #eb4d4b;
      }

      #backlight {
          margin-right: 8px;
          padding-left: 16px;
          padding-right: 16px;
          border-radius: 10px;
          transition: none;
          color: #ffffff;
          background: @bg-color;
      }

      #battery {
          padding-left: 16px;
          padding-right: 16px;
          border-radius: 10px;
          transition: none;
          color: #ffffff;
          background: @bg-color;
      }

      #battery.charging {
          color: #ffffff;
          background-color: #26A65B;
      }

      #battery.warning:not(.charging) {
          background-color: #ffbe61;
          color: black;
      }

      #battery.critical:not(.charging) {
          background-color: #f53c3c;
          color: #ffffff;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      #tray {
          margin-right: 8px;
          padding-left: 16px;
          padding-right: 16px;
          border-radius: 10px;
          transition: none;
          color: #ffffff;
          background: @bg-color;
      }

      @keyframes blink {
          to {
              background-color: #ffffff;
              color: #000000;
          }
      }
    '';
  };
}
