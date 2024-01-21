{ pkgs, ... }: {
  powerManagement = {
    enable = true;
    # powertop.enable = true;
  };

  services.tlp = {
    enable = true;
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
