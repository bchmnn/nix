{ ... }: {
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    includes = [
      "config.d/*"
    ];
  };

  home.file.".ssh/config.d/.keep".source = builtins.toFile "keep" "";

  services.ssh-agent = {
    enable = true;
  };
}
