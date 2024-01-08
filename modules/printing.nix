{ pkgs, config, ... }: {
  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [
      pkgs.mfcl3750cdwcupswrapper
    ];
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };

  /*
  hardware.printers = {
    ensurePrinters = [
      {
        name = "Brother MFC-L3750CDW series";
        location = "Home";
        deviceUri = "ipp://BROTHER-ETH.local.:631/ipp/print";
        model =
      }
    ]
  }
  */

  environment.systemPackages = with pkgs; with config.bchmnn; lib.optionals (gui.enable) [
    system-config-printer
  ];
}
