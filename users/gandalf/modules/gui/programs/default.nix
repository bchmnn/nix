{ pkgs, lib, nixosConfig, ... }: {

  imports = [
    ./alacritty.nix
    ./chromium
    ./discord.nix
    ./games.nix
    ./keyring.nix
    ./obs.nix
    ./vscode.nix
    ./zathura.nix
  ];

  home.packages = with pkgs; [

    firefox # a web browser built from firefox source tree
    thunderbird # a full-featured e-mail client
    speechd # common interface to speech synthesis - https://support.mozilla.org/en-us/kb/speechd-setup
    tor-browser # privacy-focused browser routing traffic through the tor network
    qbittorrent # featureful free software bittorrent client
    element-desktop # a feature-rich client for matrix.org

    telegram-desktop # telegram desktop messaging app
    signal-desktop # private, simple, and secure messenger
    zoom-us # zoom.us video conferencing application

    gnome.simple-scan # simple scanning utility
    gnome.gnome-font-viewer # program that can preview fonts and create thumbnails for fonts
    pppdf
    feh # a light-weight image viewer
    vlc # cross-platform media player and streaming server
    zathura # a highly customizable and functional pdf viewer
    neovide # a simple graphical user interface for neovim

    obsidian # a powerful knowledge base that works on top of a local folder of plain text markdown files
    gimp # the gnu image manipulation program
    (calibre.override { unrarSupport = true; })
    libreoffice # comprehensive, professional-quality productivity suite, a variant of openoffice.org
    xournalpp # a handwriting notetaking software with pdf annotation support
    libsForQt5.okular # kde document viewer
    carla # audio plugin host
    picard # musicbrainz picard audio file tagger

  ] ++ lib.optionals nixosConfig.bchmnn.printing.enable [
    system-config-printer # graphical user interface for cups administration

  ] ++ lib.optionals nixosConfig.bchmnn.games.enable [
    openjdk17 # the open-source java development kit
    prismlauncher # a free, open source launcher for minecraft
    # retroarchFull # multi-platform emulator frontend for libretro cores

  ] ++ lib.optionals nixosConfig.bchmnn.ratbag.enable [
    piper # gtk frontend for ratbagd mouse config daemon

  ];

}
