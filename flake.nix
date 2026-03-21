{
  description = "Jayden's NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-colors.url = "github:misterio77/nix-colors";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";
    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };

  outputs = inputs: let
    hosts = {
      "kayak" = {
        system = "x86_64-linux";
        stateVersion = "23.11";
        type = "desktop";
      };
      "racecar" = {
        system = "x86_64-linux";
        stateVersion = "23.11";
        type = "desktop";
      };
      "radar" = {
        system = "x86_64-linux";
        stateVersion = "25.05";
        type = "server";
      };
    };
  in {
    nixosConfigurations = import ./util/mkNixosConfigs.nix {inherit inputs hosts;};
    homeConfigurations = import ./util/mkHomeConfigs.nix {inherit inputs hosts;};
  };
}
