{
  inputs,
  hosts,
}: let
  root = inputs.self;
in
  builtins.listToAttrs (
    builtins.map (
      host: {
        name = host.name;
        value = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages.${host.system};
          modules = [
            "${root}/modules/home-manager"
            "${root}/hosts/${host.name}/home.nix"
          ];
          extraSpecialArgs = {
            inherit inputs host root;
          };
        };
      }
    )
    hosts
  )
