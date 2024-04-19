{
  description = "Nix los hier";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland?ref=v0.39.0";
      inputs.hyprland.follows = "nixpkgs";
    };
    hy3 = {
      url = "github:outfoxxed/hy3";
      inputs.hyprland.follows = "hyprland";
    };

    waybar.url = "github:Alexays/Waybar";

    ags.url = "github:Aylur/ags";

  };
  outputs = { self, nixpkgs, nixos-hardware, ... }@inputs: {
    nixosConfigurations = {
      W530 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [

          inputs.hyprland.nixosModules.default

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

          inputs.hyprland.nixosModules.default

          ./modules
          ./hosts/T430

          # nixos-hardware.nixosModules.lenovo-thinkpad-t430

          inputs.home-manager.nixosModules.home-manager

          {
            imports = [ ./users/gandalf ];
          }

        ];
      };
      IROH = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [

          inputs.hyprland.nixosModules.default

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
