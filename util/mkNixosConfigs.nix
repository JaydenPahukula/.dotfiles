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
        value = inputs.nixpkgs.lib.nixosSystem {
          system = host.system;
          modules = [
            "${root}/modules/nixos" # import common modules (important)
            "${root}/hosts/${host.name}/configuration.nix" # host-specific config
          ];
          specialArgs = {
            inherit inputs host root;
          };
        };
      }
    )
    hosts
  )
