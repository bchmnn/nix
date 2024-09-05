{ ... }@inputs: {

  imports = [
    ./hardware.nix
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-laptop-acpi_call
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
  ];

  networking.hostName = "W530";

  bchmnn = {

    power = {
      tlp = {
        settings = {
          # performance | powersave
          CPU_SCALING_GOVERNOR_ON_AC = "performance";
          CPU_SCALING_GOVERNOR_ON_BAT = "performance";
          # performance | balance_performance | default | balance_power | power
          CPU_ENERGY_PERF_POLICY_ON_AC = "power";
          CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
          # performance | balanced | low-power
          PLATFORM_PROFILE_ON_AC = "low-power";
          PLATFORM_PROFILE_ON_BAT = "low-power";
          CPU_MIN_PERF_ON_AC = 0;
          CPU_MAX_PERF_ON_AC = 100;
          CPU_MIN_PERF_ON_BAT = 0;
          CPU_MAX_PERF_ON_BAT = 100;
        };
      };
    };


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
    sync.enable = false;

    devenv.enable = true;
    virtualisation.enable = true;
    games.enable = false;
    ratbag.enable = true;

    ai.enable = false;

  };

  services.logind.lidSwitch = "ignore";

}
