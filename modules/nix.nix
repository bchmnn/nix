{ ... }: {
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  nixpkgs.overlays = [
    (self: super: {
      mfcl3750cdwlpr = (super.callPackage ../overlays/mfcl3750cdw.nix {}).driver;
      mfcl3750cdwcupswrapper = (super.callPackage ../overlays/mfcl3750cdw.nix {}).cupswrapper;
    })
  ];

  system.stateVersion = "23.05";
}
