{ config, ... }: {
  boot.loader.systemd-boot.memtest86.enable = config.boot.loader.systemd-boot.enable;
  boot.loader.grub.memtest86.enable = config.boot.loader.grub.enable;
}
