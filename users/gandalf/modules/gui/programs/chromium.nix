{ config, pkgs, lib, ... }:
let

  icons = {
    chromium = pkgs.fetchurl {
      url = "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/Chromium_Logo.svg/240px-Chromium_Logo.svg.png";
      sha256 = "ff6383a5c08745100e1f8720397c3d6e1b30bc6d4a329cf44bbac16ec03948e7";
      meta.licenses = lib.licenses.publicDomain;
    };
    spotify = pkgs.fetchurl {
      url = "https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Spotify_icon.svg/232px-Spotify_icon.svg.png";
      sha256 = "4251a663072b97fe5434638d9c58bbe20c2aea6da44e8d614f664b324ffe9e73";
      meta.licenses = lib.licenses.publicDomain;
    };
    teams = pkgs.fetchurl {
      url = "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c9/Microsoft_Office_Teams_%282018%E2%80%93present%29.svg/258px-Microsoft_Office_Teams_%282018%E2%80%93present%29.svg.png";
      sha256 = "a7bf37b6132e45c3c3314e7ed3a465138caabe3d87535a8b82a84be6a5f70dac";
      meta.licenses = lib.licenses.publicDomain;
    };
    outlook = pkgs.fetchurl {
      url = "https://upload.wikimedia.org/wikipedia/commons/thumb/d/df/Microsoft_Office_Outlook_%282018%E2%80%93present%29.svg/258px-Microsoft_Office_Outlook_%282018%E2%80%93present%29.svg.png";
      sha256 = "565fff2ed6a3c4c98daf7a2b56aad386c2d076f4f5b88199785593eb380eb3d4";
      meta.licenses = lib.licenses.publicDomain;
    };
    whatsapp = pkgs.fetchurl {
      url = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/WhatsApp.svg/240px-WhatsApp.svg.png";
      sha256 = "65b4eeab9b5a02c46f75f26abeac3c72a479cf8fce829b7f9c46f59e9a7f9785";
      meta.licenses = lib.licenses.publicDomain;
    };
  };

in
{

  programs.chromium = {
    enable = true;
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

