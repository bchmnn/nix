{ ... }: {

  services.syncthing = {

  };

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
    };

    user = "gandalf";
    dataDir = "/home/gandalf";

    overrideFolders = true;
  };

}
