{ config, pkgs, ... }:
let

  icons = {
    chromium = ./icons/chromium.png;
    spotify = ./icons/spotify.png;
    teams = ./icons/teams.png;
    outlook = ./icons/outlook.png;
    whatsapp = ./icons/whatsapp.png;
  };

in
{

  programs.chromium = {
    enable = true;
    package = (pkgs.chromium.override { enableWideVine = true; });
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # vimium
    ];
  };

  xdg.dataFile = {
    "applications/chromium-development.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Chromium (Development Modus)
      Exec=${pkgs.chromium}/bin/chromium --allow-file-access-from-files --disable-site-isolation-trials --allow-running-insecure-content --no-referrers --unlimited-storage --user-data-dir=${config.xdg.dataHome}/chromium-development/data --disable-web-security
      Terminal=false
      Icon=${icons.chromium}
    '';
    "applications/spotify.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Spotify
      Exec=${pkgs.chromium}/bin/chromium --app=https://spotify.com
      Terminal=false
      Icon=${icons.spotify}
    '';
    "applications/teams.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Microsoft Teams
      Exec=${pkgs.chromium}/bin/chromium --app=https://teams.microsoft.com
      Terminal=false
      Icon=${icons.teams}
    '';
    "applications/outlook.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Microsoft Outlook
      Exec=${pkgs.chromium}/bin/chromium --app=https://outlook.office365.com/mail
      Terminal=false
      Icon=${icons.outlook}
    '';
    "applications/whatsapp.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=WhatsApp
      Exec=${pkgs.chromium}/bin/chromium --app=https://web.whatsapp.com
      Terminal=false
      Icon=${icons.whatsapp}
    '';
  };

}

