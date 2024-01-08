{ lib, config, ... }: with config.bchmnn; lib.mkIf (gui.enable && lib.elem "i3" gui.flavour) {

  /*
  services.xserver.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  programs.sway.enable = true;
  */

}
