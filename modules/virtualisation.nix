{ config, lib, pkgs, ... }: lib.mkIf config.bchmnn.virtualisation.enable {

  # virt-manager
  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };
    libvirtd.enable = true;
  };
  programs = {
    dconf.enable = true;
    virt-manager.enable = true;
  };
  environment.systemPackages = with pkgs; [ virtiofsd ];

}
