{
  description = "Nix los hier";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      W530 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [

          ./modules
          ./hosts/W530

          inputs.home-manager.nixosModules.home-manager

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

          inputs.home-manager.nixosModules.home-manager

          {
            imports = [ 
              ./users/gandalf
            ];
          }

        ];
      };
      IROH = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [

          ./modules
          ./hosts/IROH

          inputs.home-manager.nixosModules.home-manager

          {
            imports = [ ./users/gandalf ];
          }

        ];
      };
    };
  };
}
