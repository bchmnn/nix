{ ... }@inputs:
let
  aliases = import ../../modules/aliases.nix;
in
{
  users.users.gandalf = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" "docker" ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {
    inherit inputs;
  };

  home-manager.users.gandalf = { pkgs, ... }: {
    imports = [
      ./modules
    ];

    config = {
      home = {
        username = "gandalf";
        homeDirectory = "/home/gandalf";
        shellAliases = aliases;
        stateVersion = "23.05";
      };
    };
  };

}
