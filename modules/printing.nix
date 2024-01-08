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

  hardware.printers = {
    ensurePrinters = [
      {
        name = "Brother-MFC-L3750CDW-series";
        location = "Home";
        deviceUri = "dnssd://Brother%20MFC-L3750CDW%20series._ipp._tcp.local/?uuid=e3248000-80ce-11db-8000-b4220094c09b";
        model = "brother_mfcl3750cdw_printer_en.ppd";
      }
    ];
    ensureDefaultPrinter = "Brother-MFC-L3750CDW-series";
  };

  environment.systemPackages = with pkgs; with config.bchmnn; lib.optionals (gui.enable) [
    system-config-printer
  ];
}
