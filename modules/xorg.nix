{ lib, config, ... }: with config.bchmnn; lib.mkIf (gui.enable && lib.elem "i3" gui.flavour) {

  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw

  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    libinput.enable = true;
  };

}

