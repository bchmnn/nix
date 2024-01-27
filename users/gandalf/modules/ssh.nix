{ ... }: {
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };

  services.ssh-agent = {
    enable = true;
  };
}
