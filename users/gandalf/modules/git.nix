{ ... }: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    signing = {
      signByDefault = true;
      key = "732A612DAD28067D";
    };
    userEmail = "jacob.bachmann@posteo.de";
    userName = "Jacob Bachmann";
    extraConfig = {
      init = { defaultBranch = "main"; };
      core.editor = "nvim";
      pull.rebase = false;
      push.autoSetupRemote = true;
    };
  };
}
