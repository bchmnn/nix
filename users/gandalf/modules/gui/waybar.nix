{ pkgs, inputs, ... }:
let
  check-battery = pkgs.writeShellScript "check-battery" ''
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
in
{
  xdg.configFile = {
    "waybar/swaybar.json".text = ''
      [
        {
          "backlight": {
            "device": "intel_backlight",
            "format": "{percent}% {icon}",
            "format-icons": [
              "󰌶",
              "󱩎",
              "󱩏",
              "󱩐",
              "󱩑",
              "󱩒",
              "󱩓",
              "󱩔",
              "󱩕",
              "󱩖",
              "󰛨"
            ]
          },
          "battery": {
            "format": "{capacity}% {icon}",
            "format-alt": "{time} {icon}",
            "format-charging": "{capacity}% 󰂄",
            "format-icons": [
              "󰂃",
              "󰁺",
              "󰁻",
              "󰁼",
              "󰁽",
              "󰁾",
              "󰁿",
              "󰂀",
              "󰂁",
              "󰂂",
              "󰁹"
            ],
            "format-plugged": "{capacity}% ",
            "on-update": "${check-battery}",
            "states": {
              "critical": 15,
              "warning": 30
            }
          },
          "clock": {
            "actions": {
              "on-click": "tz_up"
            },
            "format": "{:%a, %d %b, %H:%M}",
            "timezones": [
              "Europe/Berlin"
            ],
            "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>"
          },
          "custom/mem": {
            "exec": "free -h | awk '/Mem:/{printf $3}'",
            "format": "{} 󰍛",
            "interval": 3,
            "tooltip": false
          },
          "layer": "top",
          "margin": "5 5 5 5",
          "modules-center": [
            "clock"
          ],
          "modules-left": [
            "sway/workspaces",
            "sway/window",
            "sway/mode"
          ],
          "modules-right": [
            "tray",
            "network",
            "pulseaudio",
            "custom/mem",
            "temperature",
            "backlight",
            "battery"
          ],
          "name": "swaybar",
          "network": {
            "format": "{ifname}",
            "format-disconnected": "󰈂",
            "format-ethernet": "eth 󰈁",
            "format-wifi": "{signalStrength}% ",
            "interval": 1,
            "tooltip-format": "{ifname} via {gwaddr} 󰈁",
            "tooltip-format-disconnected": "Disconnected",
            "tooltip-format-ethernet": "{ifname} ",
            "tooltip-format-wifi": "{essid} ({signalStrength}%) "
          },
          "pulseaudio": {
            "format": "{volume}% {icon} {format_source}",
            "format-bluetooth": "{volume}% {icon} {format_source}",
            "format-bluetooth-muted": "󰖁 {icon} {format_source}",
            "format-icons": {
              "car": "",
              "default": [
                "󰕿",
                "󰖀",
                "󰕾"
              ],
              "hands-free": "󰋎",
              "headphone": "",
              "headset": "󰋎",
              "phone": "",
              "portable": ""
            },
            "format-muted": "󰖁 {format_source}",
            "format-source": "{volume}% ",
            "format-source-muted": "",
            "min-length": 13,
            "on-click": "${pkgs.pavucontrol}/bin/pavucontrol",
            "reverse-scrolling": 1
          },
          "sway/mode": {
            "format": "<span style=\"italic\">{}</span>"
          },
          "sway/window": {
            "format": "{title}",
            "max-length": 43
          },
          "sway/workspaces": {
            "disable-scroll": true,
            "persistent-workspaces": {
              "1": [],
              "2": [],
              "3": [],
              "4": []
            }
          },
          "temperature": {
            "critical-threshold": 80,
            "format": "{temperatureC}°C {icon}",
            "format-icons": [
              "",
              "",
              "",
              "",
              ""
            ],
            "tooltip": false
          },
          "tray": {
            "icon-size": 16,
            "spacing": 0
          }
        }
      ]
    '';

    "waybar/swaybar.css".text = ''
      @define-color bg-color #212529;

      window.swaybar,
      window.swaybar * {
          border: none;
          border-radius: 0;
          font-family: DejaVuSansM Nerd Font;
          min-height: 20px;
      }

      window.swaybar#waybar {
          background: transparent;
      }

      window.swaybar#waybar.hidden {
          opacity: 0.2;
      }

      window.swaybar #workspaces {
          padding-left: 8px;
          padding-right: 8px;
          margin-right: 8px;
          border-radius: 10px;
          transition: none;
          background: @bg-color;
      }

      window.swaybar #workspaces button {
          transition: none;
          color: #7c818c;
          background: transparent;
          padding: 5px;
          font-size: 18px;
      }

      window.swaybar #workspaces button.persistent {
          color: #7c818c;
          font-size: 12px;
      }

      window.swaybar #workspaces button:hover {
          transition: none;
          box-shadow: inherit;
          text-shadow: inherit;
          border-radius: inherit;
          color: @bg-color;
          background: #7c818c;
      }

      window.swaybar #workspaces button.focused {
          color: white;
      }

      window.swaybar #workspaces button.visible {
          color: white;
      }

      window.swaybar #window {
          padding-left: 16px;
          padding-right: 16px;
          margin-right: 8px;
          border-radius: 10px 10px 10px 10px;
          transition: none;
          color: #ffffff;
          background: @bg-color;
      }

      window.swaybar #mode {
          padding-left: 16px;
          padding-right: 16px;
          border-radius: 10px;
          transition: none;
          color: #ffffff;
          background: @bg-color;
      }

      window.swaybar #clock {
          padding-left: 16px;
          padding-right: 16px;
          border-radius: 10px 10px 10px 10px;
          transition: none;
          color: #ffffff;
          background: @bg-color;
      }

      window.swaybar #network {
          margin-right: 8px;
          padding-left: 16px;
          padding-right: 16px;
          border-radius: 10px;
          transition: none;
          color: #ffffff;
          background: @bg-color;
      }

      window.swaybar #pulseaudio {
          margin-right: 8px;
          padding-left: 16px;
          padding-right: 16px;
          border-radius: 10px;
          transition: none;
          color: #ffffff;
          background: @bg-color;
      }

      window.swaybar #pulseaudio.muted {
          background-color: #90b1b1;
          color: #2a5c45;
      }

      window.swaybar #custom-mem {
          margin-right: 8px;
          padding-left: 16px;
          padding-right: 16px;
          border-radius: 10px;
          transition: none;
          color: #ffffff;
          background: @bg-color;
      }

      window.swaybar #temperature {
          margin-right: 8px;
          padding-left: 16px;
          padding-right: 16px;
          border-radius: 10px;
          transition: none;
          color: #ffffff;
          background: @bg-color;
      }

      window.swaybar #temperature.critical {
          background-color: #eb4d4b;
      }

      window.swaybar #backlight {
          margin-right: 8px;
          padding-left: 16px;
          padding-right: 16px;
          border-radius: 10px;
          transition: none;
          color: #ffffff;
          background: @bg-color;
      }

      window.swaybar #battery {
          padding-left: 16px;
          padding-right: 16px;
          border-radius: 10px;
          transition: none;
          color: #ffffff;
          background: @bg-color;
      }

      window.swaybar #battery.charging {
          color: #ffffff;
          background-color: #26A65B;
      }

      window.swaybar #battery.warning:not(.charging) {
          background-color: #ffbe61;
          color: black;
      }

      window.swaybar #battery.critical:not(.charging) {
          background-color: #f53c3c;
          color: #ffffff;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      window.swaybar #tray {
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

    "waybar/hyprbar.json".text = ''
      [
        {
          "backlight": {
            "device": "intel_backlight",
            "format": "{percent}% {icon}",
            "format-icons": [
              "󰌶",
              "󱩎",
              "󱩏",
              "󱩐",
              "󱩑",
              "󱩒",
              "󱩓",
              "󱩔",
              "󱩕",
              "󱩖",
              "󰛨"
            ]
          },
          "battery": {
            "format": "{capacity}% {icon}",
            "format-alt": "{time} {icon}",
            "format-charging": "{capacity}% 󰂄",
            "format-icons": [
              "󰂃",
              "󰁺",
              "󰁻",
              "󰁼",
              "󰁽",
              "󰁾",
              "󰁿",
              "󰂀",
              "󰂁",
              "󰂂",
              "󰁹"
            ],
            "format-plugged": "{capacity}% ",
            "on-update": "${check-battery}",
            "states": {
              "critical": 15,
              "warning": 30
            }
          },
          "clock": {
            "format": "{:%a %b %d %H:%M}",
            "timezones": [
              "Europe/Berlin"
            ],
            "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>"
          },
          "custom/mem": {
            "exec": "free -h | awk '/Mem:/{printf $3}'",
            "format": "{} 󰍛",
            "interval": 3,
            "tooltip": false
          },
          "hyprland/window": {
            "format": "{title}",
            "separate-outputs": true
          },
          "hyprland/workspaces": {
            "disable-scroll": true,
            "persistent-workspaces": {
              "1": [],
              "10": [],
              "2": [],
              "3": [],
              "4": [],
              "5": [],
              "6": [],
              "7": [],
              "8": [],
              "9": []
            }
          },
          "layer": "top",
          "margin": "5 5 5 5",
          "modules-center": [],
          "modules-left": [
            "hyprland/workspaces",
            "hyprland/window"
          ],
          "modules-right": [
            "tray",
            "network",
            "pulseaudio",
            "custom/mem",
            "temperature",
            "backlight",
            "battery",
            "clock"
          ],
          "name": "hyprbar",
          "network": {
            "format": "{ifname}",
            "format-disconnected": "󰈂",
            "format-ethernet": "eth 󰈁",
            "format-wifi": "{signalStrength}% ",
            "interval": 1,
            "tooltip-format": "{ifname} via {gwaddr} 󰈁",
            "tooltip-format-disconnected": "Disconnected",
            "tooltip-format-ethernet": "{ifname} ",
            "tooltip-format-wifi": "{essid} ({signalStrength}%) "
          },
          "pulseaudio": {
            "format": "{volume}% {icon} {format_source}",
            "format-bluetooth": "{volume}% {icon} {format_source}",
            "format-bluetooth-muted": "󰖁 {icon} {format_source}",
            "format-icons": {
              "car": "",
              "default": [
                "󰕿",
                "󰖀",
                "󰕾"
              ],
              "hands-free": "󰋎",
              "headphone": "",
              "headset": "󰋎",
              "phone": "",
              "portable": ""
            },
            "format-muted": "󰖁 {format_source}",
            "format-source": "{volume}% ",
            "format-source-muted": "",
            "min-length": 13,
            "on-click": "${pkgs.pavucontrol}/bin/pavucontrol",
            "reverse-scrolling": 1
          },
          "temperature": {
            "critical-threshold": 80,
            "format": "{temperatureC}°C {icon}",
            "format-icons": [
              "",
              "",
              "",
              "",
              ""
            ],
            "tooltip": false
          },
          "tray": {
            "icon-size": 16,
            "show-passive-items": true,
            "spacing": 4
          }
        }
      ]
    '';

    "waybar/hyprbar.css".text = ''
      window.hyprbar,
      window.hyprbar * {
        border: none;
        border-radius: 10px;
        font-family: DejaVuSansM Nerd Font;
        min-height: 20px;
      }

      window.hyprbar#waybar {
        background: #ffffff;
      }

      window.hyprbar#waybar.hidden {
        opacity: 0.2;
      }

      window.hyprbar #workspaces {
        padding-left: 8px;
        padding-right: 8px;
        margin-right: 8px;
        transition: none;
      }

      window.hyprbar #workspaces button {
        transition: none;
        color: black;
        background: transparent;
        padding: 5px;
        font-size: 18px;
        border-radius: 0px;
      }

      window.hyprbar #workspaces button.empty {
        color: #7c818c;
      }

      window.hyprbar #workspaces button.persistent {
        font-size: 12px;
      }

      window.hyprbar #workspaces button.visible {
        color: black;
        font-size: 18px;
      }

      window.hyprbar #workspaces button.visible.hosting-monitor {
        background: lightgray;
      }

      window.hyprbar #workspaces button:hover {
        color: white;
        background: black;
      }

      window.hyprbar #window {
        padding-left: 16px;
        padding-right: 16px;
        transition: none;
        color: black;
        background: transparent;
      }

      window.hyprbar #tray {
        margin-right: 10px;
        padding-left: 10px;
        padding-right: 10px;
        transition: none;
        color: white;
        background: rgb(66, 118, 185);
      }

      window.hyprbar #network {
        /* margin-right: 4px; */
        padding-left: 10px;
        padding-right: 10px;
        transition: none;
        color: black;
        background: transparent;
      }

      window.hyprbar #pulseaudio {
        /* margin-right: 4px; */
        padding-left: 10px;
        padding-right: 10px;
        transition: none;
        color: black;
        background: transparent;
      }

      window.hyprbar #pulseaudio.muted {
        color: gray;
      }

      window.hyprbar #custom-mem {
        /* margin-right: 8px; */
        padding-left: 10px;
        padding-right: 10px;
        transition: none;
        color: black;
        background: transparent;
      }

      window.hyprbar #temperature {
        /* margin-right: 8px; */
        padding-left: 10px;
        padding-right: 10px;
        transition: none;
        color: black;
        background: transparent;
      }

      window.hyprbar #temperature.critical {
        background-color: #eb4d4b;
      }

      window.hyprbar #backlight {
        /* margin-right: 8px; */
        padding-left: 10px;
        padding-right: 10px;
        transition: none;
        color: black;
        background: transparent;
      }

      window.hyprbar #battery {
        padding-left: 10px;
        padding-right: 10px;
        transition: none;
        color: black;
        background: transparent;
      }

      window.hyprbar #battery.charging {
        color: #ffffff;
        background-color: #26a65b;
      }

      window.hyprbar #battery.warning:not(.charging) {
        background-color: #ffbe61;
        color: black;
      }

      window.hyprbar #battery.critical:not(.charging) {
        background-color: #f53c3c;
        color: #ffffff;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      window.hyprbar #clock {
        padding-left: 10px;
        padding-right: 16px;
        transition: none;
        color: black;
        background: transparent;
      }

      @keyframes blink {
          to {
              background-color: #ffffff;
              color: #000000;
          }
      }
    '';
  };

  programs.waybar = {
    enable = true;
    # TODO replace with (un-)stable channel version once available
    package = inputs.waybar.packages.x86_64-linux.default;
  };
}
