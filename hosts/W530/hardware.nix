{ config, lib, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "firewire_ohci" "usb_storage" "sd_mod" "sr_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelParams = [ "resume_offset=9364344" ];
  boot.resumeDevice = "/dev/disk/by-uuid/2e6bd7f5-74f0-4047-a0ab-5679b877a9fe";
  boot.initrd.luks.devices."cryptlvm".device = "/dev/disk/by-uuid/d04a2c58-4116-45d6-aa6e-2002556e6d22";

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/2e6bd7f5-74f0-4047-a0ab-5679b877a9fe";
      fsType = "btrfs";
      options = [ "subvol=@" "compress=zstd" "noatime" ];
    };

  fileSystems."/home" =
    {
      device = "/dev/disk/by-uuid/2e6bd7f5-74f0-4047-a0ab-5679b877a9fe";
      fsType = "btrfs";
      options = [ "subvol=@home" "compress=zstd" "noatime" ];
    };

  fileSystems."/root" =
    {
      device = "/dev/disk/by-uuid/2e6bd7f5-74f0-4047-a0ab-5679b877a9fe";
      fsType = "btrfs";
      options = [ "subvol=@root" "compress=zstd" "noatime" ];
    };

  fileSystems."/srv" =
    {
      device = "/dev/disk/by-uuid/2e6bd7f5-74f0-4047-a0ab-5679b877a9fe";
      fsType = "btrfs";
      options = [ "subvol=@srv" "compress=zstd" "noatime" ];
    };

  fileSystems."/var/log" =
    {
      device = "/dev/disk/by-uuid/2e6bd7f5-74f0-4047-a0ab-5679b877a9fe";
      fsType = "btrfs";
      options = [ "subvol=@log" "compress=zstd" "noatime" ];
    };

  fileSystems."/var/cache" =
    {
      device = "/dev/disk/by-uuid/2e6bd7f5-74f0-4047-a0ab-5679b877a9fe";
      fsType = "btrfs";
      options = [ "subvol=@cache" "compress=zstd" "noatime" ];
    };

  fileSystems."/tmp" =
    {
      device = "/dev/disk/by-uuid/2e6bd7f5-74f0-4047-a0ab-5679b877a9fe";
      fsType = "btrfs";
      options = [ "subvol=@tmp" "compress=zstd" "noatime" ];
    };

  fileSystems."/swap" =
    {
      device = "/dev/disk/by-uuid/2e6bd7f5-74f0-4047-a0ab-5679b877a9fe";
      fsType = "btrfs";
      options = [ "subvol=@swap" "noatime" ];
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/A410-7E4F";
      fsType = "vfat";
    };

  swapDevices = [{
    device = "/swap/swapfile";
  }];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
