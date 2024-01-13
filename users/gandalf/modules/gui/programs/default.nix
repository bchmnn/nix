{ pkgs, lib, nixosConfig, ... }: {

  imports = [
    ./alacritty.nix
    ./chromium.nix
    ./discord.nix
    ./keyring.nix
    ./obs.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    firefox
    speechd # https://support.mozilla.org/en-US/kb/speechd-setup
    gnome.nautilus
    gimp
    vlc
    qbittorrent
    gnome.simple-scan
    telegram-desktop
    signal-desktop
    zathura
    obsidian
  ] ++ lib.optionals nixosConfig.bchmnn.printing.enable [
    system-config-printer
  ];

}
