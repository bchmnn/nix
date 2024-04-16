{ pkgs, ... }: {
  nix = {
    # TODO remove once 24.05 is released
    package = pkgs.nixVersions.unstable;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
  };

  nixpkgs = {
    overlays = [
      (self: super: {
        bun-baseline = (super.callPackage ../overlays/bun-baseline.nix { });
        mfcl3750cdwlpr = (super.callPackage ../overlays/mfcl3750cdw.nix { }).driver;
        mfcl3750cdwcupswrapper = (super.callPackage ../overlays/mfcl3750cdw.nix { }).cupswrapper;
        pppdf = (super.python3Packages.callPackage ../overlays/pppdf { });
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
