{ config, lib, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" "sdhci_pci" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelParams = [ "resume_offset=18883840" ];
  boot.resumeDevice = "/dev/disk/by-label/ROOT";
  boot.initrd.luks.devices."cryptlvm".device = "/dev/disk/by-uuid/b7a904b2-cceb-47fc-832a-701e386a95db";

  fileSystems."/" =
    {
      device = "/dev/disk/by-label/ROOT";
      fsType = "btrfs";
      options = [ "subvol=@" "compress=zstd" "noatime" ];
    };

  fileSystems."/home" =
    {
      device = "/dev/disk/by-label/ROOT";
      fsType = "btrfs";
      options = [ "subvol=@home" "compress=zstd" "noatime" ];
    };

  fileSystems."/nix" =
    {
      device = "/dev/disk/by-label/ROOT";
      fsType = "btrfs";
      options = [ "subvol=@nix" "compress=zstd" "noatime" ];
    };

  fileSystems."/swap" =
    {
      device = "/dev/disk/by-label/ROOT";
      fsType = "btrfs";
      options = [ "subvol=@swap" "noatime" ];
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-label/EFI";
      fsType = "vfat";
    };

  swapDevices = [{
    device = "/swap/swapfile";
  }];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}


