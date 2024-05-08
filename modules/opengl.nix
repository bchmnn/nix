{ config, lib, pkgs, ... }: {
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  environment.variables = lib.mkIf (
    builtins.elem
    pkgs.intel-media-driver
    config.hardware.opengl.extraPackages
  ) {
    LIBVA_DRIVER_NAME = "iHD";
  };

}
