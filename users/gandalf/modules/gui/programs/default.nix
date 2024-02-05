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
    tor-browser
    firefox
    thunderbird
    speechd # https://support.mozilla.org/en-US/kb/speechd-setup
    gnome.nautilus
    gimp
    vlc
    calibre
    qbittorrent
    gnome.simple-scan
    telegram-desktop
    signal-desktop
    zoom-us
    zathura
    obsidian
    libreoffice
    carla # audio plugin host
    aether-lv2 # an algorithmic reverb lv2 based on cloudseed
    picard # musicbrainz picard audio file tagger
  ] ++ lib.optionals nixosConfig.bchmnn.printing.enable [
    system-config-printer
  ] ++ lib.optionals nixosConfig.bchmnn.games.enable [
    prismlauncher
    openjdk17
  ];

}
