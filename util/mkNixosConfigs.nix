{
  inputs,
  hosts,
}: let
  root = inputs.self;
  validatedHosts = import ./validateHosts.nix hosts;
in
  builtins.mapAttrs (
    name: host:
      inputs.nixpkgs.lib.nixosSystem {
        system = host.system;
        modules = [
          "${root}/modules/nixos"
          "${root}/hosts/${host.name}/configuration.nix" # host-specific system config
        ];
        specialArgs = {
          inherit inputs host root;
        };
      }
  )
  validatedHosts
