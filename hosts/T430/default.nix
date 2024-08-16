{ ... }@inputs: {

  imports = [
    ./hardware.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t430
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-laptop-acpi_call
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
  ];

  networking.hostName = "T430";

  bchmnn = {

    gui = {
      enable = true;
      greeter.enable = false;
      flavour = [ "sway" ];
    };
    nvidia.enable = false;
    audio = {
      enable = true;
      pipewire-wine-fix.enable = false;
    };
    bluetooth.enable = true;
    printing.enable = true;
    vpn.enable = true;
    sync.enable = true;

    devenv.enable = true;
    virtualisation.enable = true;
    games.enable = true;
    ratbag.enable = true;

    ai.enable = false;

  };

}
