{inputs}: name: {system, ...}: let
  root = inputs.self;
in
  inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.${system};
    modules = [
      "${root}/modules/hm"
      "${root}/hosts/${name}/home.nix"
    ];
    extraSpecialArgs = {
      inherit inputs root name;
    };
  }
