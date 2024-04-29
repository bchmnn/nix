{ pkgs, config, ... }: with config.bchmnn; {
  powerManagement = {
    enable = true;
  };

  services.tlp = {
    enable = !builtins.elem "gnome" gui.flavour;
    settings = {
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "balanced";
    };
  };

  environment.systemPackages = with pkgs; [
    powertop
  ];
}
