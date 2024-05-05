{ lib, config, pkgs, ... }: lib.mkIf config.bchmnn.gui.enable {
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    config.common.default = "*";
    extraPortals = with lib; with config.bchmnn; optionals (elem "sway" gui.flavour) [
      pkgs.xdg-desktop-portal-wlr
    ];
  };
}
