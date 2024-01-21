{ pkgs, nixosConfig, ... }: {
  home.packages = [
    (import ./nix-update.nix { inherit pkgs nixosConfig; })
  ];
}
