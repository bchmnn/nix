{ lib, config, pkgs, ... }: lib.mkIf config.bchmnn.gui.enable {
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    # upper has been replaced by following
    config.common.default = "*";
    extraPortals = with lib; with config.bchmnn; optionals (elem "sway" gui.flavour) [
      pkgs.xdg-desktop-portal-wlr
    ] ++ optionals (elem "hyprland" gui.flavour) [
      pkgs.xdg-desktop-portal-hyprland
    ];
  };
}
