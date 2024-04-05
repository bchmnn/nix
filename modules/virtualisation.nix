{ config, lib, pkgs, ... }: lib.mkIf config.bchmnn.virtualisation.enable {

  # virt-manager
  virtualisation = {
    libvirtd.enable = true;
    podman = {
      enable = true;
      # create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      # required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };
  programs = {
    dconf.enable = true;
    virt-manager.enable = true;
  };
  environment.systemPackages = with pkgs; [ virtiofsd ];

}
