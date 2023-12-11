{ config, lib, pkgs, ... }: lib.mkIf config.bchmnn.virtualisation.enable {

  # virt-manager
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [ virt-manager ];

}
