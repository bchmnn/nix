{ lib, nixosConfig, ... }: {

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = lib.mkIf nixosConfig.bchmnn.virtualisation.enable {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
    "org/gnome/desktop/interface" = {
      "color-scheme" = "prefer-dark";
    };
  };

}
