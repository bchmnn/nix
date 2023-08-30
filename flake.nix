{
  description = "Nix los hier";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      W530 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [

          ./hosts/W530
          ./modules

          home-manager.nixosModules.home-manager
          {
            imports = [ ./users/gandalf ];
          }

        ];
      };
    };
  };
}
