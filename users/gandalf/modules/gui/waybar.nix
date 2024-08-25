{ pkgs, nixosConfig, ... }:
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
  tailscale-status = pkgs.writeShellScript "tailscale-status" ''
    if ${nixosConfig.services.tailscale.package}/bin/tailscale status > /dev/null 2>&1; then
      echo " "
    else
      echo " "
    fi
  '';
  tailscale-toggle = pkgs.writeShellScript "tailscale-toggle" ''
    if ${nixosConfig.services.tailscale.package}/bin/tailscale status > /dev/null 2>&1; then
      pkexec ${nixosConfig.services.tailscale.package}/bin/tailscale down
    else
      pkexec ${nixosConfig.services.tailscale.package}/bin/tailscale up --accept-routes --exit-node=j4m35-bl0nd
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
            "format": "{percent}% {icon} ",
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
            "format": "{capacity}% {icon} ",
            "format-alt": "{time} {icon} ",
            "format-charging": "{capacity}% 󰂄 ",
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
            "format-plugged": "{capacity}%  ",
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
            "format": "{} 󰍛 ",
            "interval": 3,
            "tooltip": false
          },
          "custom/separator": {
            "format": "|",
            "interval": "once",
            "tooltip": false
          },
          "disk": {
            "format": "{specific_free:0.0f}GB  ",
            "unit": "GB"
          },
          "sway/mode": {
            "format": "<span style=\"italic\">{}</span>"
          },
          "sway/window": {
            "format": "{title}",
          },
          "sway/workspaces": {
            "disable-scroll": true,
            "persistent-workspaces": {
              "1": [],
              "2": [],
              "3": [],
              "4": [],
              "5": [],
              "6": [],
              "7": [],
              "8": [],
              "9": [],
              "10": [],
            }
          },
          "layer": "top",
          "modules-center": [
          ],
          "modules-left": [
            "sway/workspaces",
            "sway/window",
            "sway/mode"
          ],
          "modules-right": [
            "tray",
            "network",
            "custom/tailscale",
            "custom/separator",
            "pulseaudio",
            "custom/separator",
            "disk",
            "custom/separator",
            "custom/mem",
            "custom/separator",
            "temperature",
            "custom/separator",
            "backlight",
            "custom/separator",
            "battery",
            "custom/separator",
            "clock"
          ],
          "name": "swaybar",
          "network": {
            "format": "{ifname}",
            "format-disconnected": "󰈂 ",
            "format-ethernet": "eth 󰈁 ",
            "format-wifi": "{signalStrength}%  ",
            "interval": 1,
            "tooltip-format": "{ifname} via {gwaddr} 󰈁 ",
            "tooltip-format-disconnected": "Disconnected",
            "tooltip-format-ethernet": "{ifname}  ",
            "tooltip-format-wifi": "{essid} ({signalStrength}%)  "
          },
          "custom/tailscale": {
            "exec": "${tailscale-status}",
            "interval": 1,
            "on-click": "${tailscale-toggle}",
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
            "format-source": "{volume}%  ",
            "format-source-muted": " ",
            "on-click": "${pkgs.pavucontrol}/bin/pavucontrol",
            "reverse-scrolling": 1
          },
          "temperature": {
            "critical-threshold": 80,
            "format": "{temperatureC}°C {icon} ",
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

    "waybar/swaybar.css".text = ''
      window.swaybar,
      window.swaybar * {
        border: none;
        font-family: DejaVuSansM Nerd Font;
        font-size: 13px;
      }

      window.swaybar #custom-separator {
        padding-right: 6px;
        color: #d3d3d3;
      }

      window.swaybar#waybar {
        background: linear-gradient(to bottom, #ffffff, #f9f9f9);
      }

      window.swaybar#waybar.hidden {
        opacity: 0.2;
      }

      window.swaybar #workspaces {
        padding-left: 8px;
        padding-right: 8px;
        margin-right: 8px;
        transition: none;
      }

      window.swaybar #workspaces button {
        transition: none;
        color: black;
        background: transparent;
        padding: 2px;
        /* font-size: 18px; */
        border-radius: 0px;
      }

      window.swaybar #workspaces button.empty {
        color: #7c818c;
      }

      window.swaybar #workspaces button.persistent {
        /* font-size: 12px; */
      }

      window.swaybar #workspaces button.visible {
        color: black;
        /* font-size: 18px; */
      }

      window.swaybar #workspaces button.focused {
        background: lightgray;
      }

      window.swaybar #workspaces button:hover {
        color: white;
        background: black;
      }

      window.swaybar #window {
        padding-left: 8px;
        padding-right: 8px;
        transition: none;
        color: black;
        background: transparent;
      }

      window.swaybar #mode {
        padding-left: 16px;
        padding-right: 16px;
        transition: none;
        color: black;
        background: transparent;
      }

      window.swaybar #tray {
        margin-right: 10px;
        padding-left: 10px;
        padding-right: 10px;
        border-radius: 10px;
        transition: none;
        color: white;
        background: rgb(66, 118, 185);
      }

      window.swaybar #network {
        padding-left: 6px;
        transition: none;
        color: black;
        background: transparent;
      }

      window.swaybar #custom-tailscale {
        padding-right: 6px;
        transition: none;
        color: black;
        background: transparent;
      }

      window.swaybar #pulseaudio {
        transition: none;
        color: black;
        background: transparent;
      }

      window.swaybar #pulseaudio.muted {
        color: gray;
      }

      window.swaybar #disk {
        transition: none;
        color: black;
        background: transparent;
      }

      window.swaybar #custom-mem {
        transition: none;
        color: black;
        background: transparent;
      }

      window.swaybar #temperature {
        transition: none;
        color: black;
        background: transparent;
      }

      window.swaybar #temperature.critical {
        background-color: #eb4d4b;
      }

      window.swaybar #backlight {
        transition: none;
        color: black;
        background: transparent;
      }

      window.swaybar #battery {
        transition: none;
        color: black;
        background: transparent;
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

      window.swaybar #clock {
        padding-right: 6px;
        margin-right: 8px;
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
  };
}
