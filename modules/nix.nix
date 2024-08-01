{ ... }@inputs: {
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
  };

  nixpkgs = {
    overlays = [
      (self: super: {
        unstable = import inputs.nixpkgs-unstable {
          system = super.system;
        };
        mfcl3750cdwlpr = (super.callPackage ../overlays/mfcl3750cdw.nix { }).driver;
        mfcl3750cdwcupswrapper = (super.callPackage ../overlays/mfcl3750cdw.nix { }).cupswrapper;
        pppdf = (super.python3Packages.callPackage ../overlays/pppdf { });
        isisdl = (super.python3Packages.callPackage ../overlays/isisdl.nix { });
        iglesia-light = (super.callPackage ../overlays/fonts/iglesia-light.nix { });
      })
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      # allow EOL version electron for obsidian
      # TODO: remove
      permittedInsecurePackages = [
        "electron-25.9.0"
      ];
    };
  };

  system.stateVersion = "23.05";
}
