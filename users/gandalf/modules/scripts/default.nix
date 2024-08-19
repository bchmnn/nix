{ pkgs, nixosConfig, ... }: {
  home.packages = [
    (import ./git-clone-list.nix { inherit pkgs; })
    (import ./nix-update.nix { inherit pkgs nixosConfig; })
  ] ++ (import ./pomodoro.nix { inherit pkgs; });
}
