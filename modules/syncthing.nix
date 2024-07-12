{ lib, config, ... }: lib.mkIf config.bchmnn.sync.enable {

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;

    settings = {
      devices = {
        T430 = {
          id = "UGQINNI-SC6F24X-5JE7YTP-LZLORTX-7GQ5NKK-YMRDRPK-JHRTWUV-4ILUJQQ";
        };
        IROH = {
          id = "PJA2MBA-66PQQEO-5KICONS-FGHDH46-YRV2X5Y-47UUP77-QXI2WNS-R33FPAK";
        };
      };

      folders = {
        "dl" = {
          path = "~/dl";
          id = "z97eb-myxtp";
          devices = [
            "IROH"
            "T430"
          ];
        };
        "docs" = {
          path = "~/docs";
          id = "rhh6x-dmymv";
          devices = [
            "IROH"
            "T430"
          ];
        };
        "music" = {
          path = "~/music";
          id = "umzur-ncrf6";
          devices = [
            "IROH"
            "T430"
          ];
        };
        "pics" = {
          path = "~/pics";
          id = "cuejs-esf7u";
          devices = [
            "IROH"
            "T430"
          ];
        };
        "tmp" = {
          path = "~/tmp";
          id = "d6k5d-hdxyh";
          devices = [
            "IROH"
            "T430"
          ];
        };
        "vids" = {
          path = "~/vids";
          id = "bjx9u-ujjwi";
          devices = [
            "IROH"
            "T430"
          ];
        };
      };
    };

    user = "gandalf";
    group = "users";
    dataDir = "/home/gandalf";

  };

}
