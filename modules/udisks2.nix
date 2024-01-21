{ ... }: {
  # needed for udiskie
  services.udisks2.enable = true;
  # enable gvfs to mount android devices
  services.gvfs.enable = true;
}
