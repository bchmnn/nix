{ pkgs, ... }: {
  home.packages = with pkgs; [
    vesktop # alternate client for discord with vencord built-in
  ];
}
