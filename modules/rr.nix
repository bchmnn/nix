{

  services.jackett = {
    enable = true;
  };

  virtualisation = {
    oci-containers = {
      containers = {
        flare-solvarr = {
          image = "ghcr.io/flaresolverr/flaresolverr:latest";
          autoStart = true;
          ports = ["127.0.0.1:8191:8191"];
          environment = {
            LOG_LEVEL = "info";
            LOG_HTML = "false";
            CAPTCHA_SOLVER = "hcaptcha-solver";
            TZ="Europe/Berlin";
          };
        };
      };
    };
  };

}
