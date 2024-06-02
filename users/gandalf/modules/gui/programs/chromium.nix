{ config, pkgs, lib, ... }:
let

  icons = {
    chromium = pkgs.fetchurl {
      url = "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/Chromium_Logo.svg/240px-Chromium_Logo.svg.png";
      sha256 = "df526fa1ba625bd619a7a938aeb504e8e3d9d7e55adc63f9802d8eadb4a3fb58";
      meta.licenses = lib.licenses.publicDomain;
    };
    spotify = pkgs.fetchurl {
      url = "https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Spotify_icon.svg/232px-Spotify_icon.svg.png";
      sha256 = "4251a663072b97fe5434638d9c58bbe20c2aea6da44e8d614f664b324ffe9e73";
      meta.licenses = lib.licenses.publicDomain;
    };
    teams = pkgs.fetchurl {
      url = "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c9/Microsoft_Office_Teams_%282018%E2%80%93present%29.svg/258px-Microsoft_Office_Teams_%282018%E2%80%93present%29.svg.png";
      sha256 = "3a7caf6bdc2f03833cb4273774af6859b29676c42844bb8f9743074768316a1f";
      meta.licenses = lib.licenses.publicDomain;
    };
    outlook = pkgs.fetchurl {
      url = "https://upload.wikimedia.org/wikipedia/commons/thumb/d/df/Microsoft_Office_Outlook_%282018%E2%80%93present%29.svg/258px-Microsoft_Office_Outlook_%282018%E2%80%93present%29.svg.png";
      sha256 = "06d3265352f03ac7ac65c230eae019a9a1e2bc94aeb8b24247a5484c4f3e15a1";
      meta.licenses = lib.licenses.publicDomain;
    };
    whatsapp = pkgs.fetchurl {
      url = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/WhatsApp.svg/240px-WhatsApp.svg.png";
      sha256 = "44ce29edaaba4fcd515702cef2f08ac6c1289f33c1d5c8983761db9d7ad8061d";
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

