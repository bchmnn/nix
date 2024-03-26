{ ... }: {

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;

    user = "gandalf";
    dataDir = "/home/gandalf";

    overrideFolders = true;
  };

}
