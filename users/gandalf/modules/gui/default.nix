{ lib, nixosConfig, ... }: {

  imports = with lib; with nixosConfig.bchmnn;
    optionals gui.enable [
      ./ags
      ./gtk.nix
      ./programs
    ] ++ optionals (gui.enable && elem "sway" gui.flavour) [
      ./sway
    ] ++ optionals (gui.enable && elem "Hyprland" gui.flavour) [
      ./hyprland
    ] ++ optionals (gui.enable && elem "i3" gui.flavour) [
      ./i3
    ];

}
