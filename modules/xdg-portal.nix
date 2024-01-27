{ lib, config, ... }: lib.mkIf config.bchmnn.gui.enable {
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    # extraPortals = [
    #   pkgs.xdg-desktop-portal-wlr
    #   pkgs.xdg-desktop-portal-gtk
    # ];
    # upper has been replaced by following
    config.common.default = "*";
  };
}
