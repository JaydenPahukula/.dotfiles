{
  description = "Jayden's NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
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

  outputs = inputs: let
    hosts = {
      "kayak" = {
        system = "x86_64-linux";
      };
    };
    mkSystem = import ./util/mksystem.nix {inherit inputs;};
    mkHome = import ./util/mkhome.nix {inherit inputs;};
  in {
    nixosConfigurations = builtins.mapAttrs mkSystem hosts;
    homeConfigurations = builtins.mapAttrs mkHome hosts;
  };
}
