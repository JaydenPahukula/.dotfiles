{inputs}: name: {system, ...}: let
  root = inputs.self;
in
  inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.${system};
    modules = [
      "${root}/modules/home-manager"
      "${root}/hosts/${name}/home.nix"
    ];
    extraSpecialArgs = {
      inherit inputs root name;
    };
  }
