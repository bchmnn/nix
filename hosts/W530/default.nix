{ ... }@inputs: {

  imports = [
    ./hardware.nix
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-laptop-acpi_call
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
  ];

  networking.hostName = "W530";

  bchmnn = {

    gui = {
      enable = true;
      greeter.enable = false;
      flavour = [ "sway" ];
    };
    nvidia.enable = false;
    audio.enable = true;
    bluetooth.enable = true;
    printing.enable = true;
    vpn.enable = true;
    sync.enable = false;

    devenv.enable = true;
    virtualisation.enable = true;
    games.enable = false;
    ratbag.enable = true;

    ai.enable = false;

  };

}
