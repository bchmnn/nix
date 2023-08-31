{ pkgs, unstable, ... }:
let
  aliases = import ../../modules/aliases.nix;
in
{
  users.users.gandalf = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
      firefox
      speechd # https://support.mozilla.org/en-US/kb/speechd-setup
      gopass
      gopass-jsonapi
      gnome.nautilus
      gimp
    ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {
    inherit unstable;
  };

  home-manager.users.gandalf = { pkgs, ... }: {
    imports = [ ./modules ];

    config = {
      home = {
        username = "gandalf";
        homeDirectory = "/home/gandalf";
        shellAliases = aliases;
        stateVersion = "23.05";
      };
    };
  };

  # programs.home-manager.enable = true;
}
