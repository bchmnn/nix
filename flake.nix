{
  description = "Nix los hier";
  inputs = {

    # TODO enable ability to switch between stable and unstable
    # TODO enable ability to include or exclude unfree software

    #nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    #nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    #home-manager.url = "github:nix-community/home-manager/release-23.05";
    #home-manager.inputs.nixpkgs.follows = "nixpkgs";
    #home-manager-unstable.url = "github:nix-community/home-manager";
    #home-manager-unstable.inputs.nixpkgs.follows = "nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };
  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      W530 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [

          ./modules
          ./hosts/W530

          home-manager.nixosModules.home-manager

          {
            imports = [ ./users/gandalf ];
          }

        ];
      };
      T430 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [

          ./modules
          ./hosts/T430

          home-manager.nixosModules.home-manager

          {
            imports = [ ./users/gandalf ];
          }

        ];
      };
    };
  };
}
