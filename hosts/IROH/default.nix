{ ... }@inputs: {

  imports = [
    ./hardware.nix
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
  ];

  networking.hostName = "IROH";

  bchmnn = {

    gui = {
      enable = true;
      greeter.enable = false;
      flavour = [ "i3" ];
    };
    nvidia.enable = true;
    audio.enable = true;
    bluetooth.enable = false;
    printing.enable = true;
    vpn.enable = true;

    devenv.enable = true;
    virtualisation.enable = true;
    games.enable = true;
    ratbag.enable = true;

    ai.enable = false;

  };

}
