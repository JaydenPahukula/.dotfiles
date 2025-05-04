{
  description = "My Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    # nixos configuration
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./system/configuration.nix
          inputs.nixos-hardware.nixosModules.framework-11th-gen-intel
        ];
      };
    };

    # home manager configuration
    homeConfigurations = {
      jayden = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          inputs.plasma-manager.homeManagerModules.plasma-manager
          inputs.nix-colors.homeManagerModules.default
          ./home/home.nix
        ];
        extraSpecialArgs = {
          inherit inputs;
          colors = import ./home/colors;
          scripts = import ./home/scripts {inherit pkgs;};
        };
      };
    };
  };
}
