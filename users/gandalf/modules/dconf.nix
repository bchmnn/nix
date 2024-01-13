{ lib, nixosConfig, ... }: {

  dconf.settings = lib.mkIf nixosConfig.bchmnn.virtualisation.enable {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

}
