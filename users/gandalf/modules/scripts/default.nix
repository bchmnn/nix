{ pkgs, nixosConfig, ... }: {
  imports = [
    ./pomodoro.nix
  ];
  home.packages = [
    (import ./git-clone-list.nix { inherit pkgs; })
    (import ./nix-update.nix { inherit pkgs nixosConfig; })
  ];
}
