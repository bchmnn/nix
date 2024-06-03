{ config, lib, ... }: {

  security.polkit.enable = true;
  security.rtkit.enable = true;
  networking.firewall.enable = true;

} // (lib.mkIf (lib.elem "sway" config.bchmnn.gui.flavour) {

  # TODO workaround to get swaylock accepting pw
  # https://github.com/NixOS/nixpkgs/issues/158025
  security.pam.services.swaylock = { };

}) // (lib.mkIf (config.bchmnn.devenv.enable) {

  networking.firewall = {
    allowedTCPPorts = [ 3000 6969 8080 ];
  };

})
