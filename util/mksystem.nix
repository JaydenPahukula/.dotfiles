{inputs}: name: {system, ...}: let
  root = inputs.self;
in
  inputs.nixpkgs.lib.nixosSystem {
    inherit system;
    modules = [
      "${root}/modules/nixos" # import common modules (important)
      "${root}/hosts/${name}/configuration.nix" # host-specific config
    ];
    specialArgs = {
      inherit inputs root name;
    };
  }
