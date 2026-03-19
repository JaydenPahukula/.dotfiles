{
  inputs,
  hosts,
}: let
  root = inputs.self;
  validatedHosts = import ./validateHosts.nix hosts;
in
  builtins.mapAttrs (
    name: host:
      inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.${host.system};
        modules = [
          "${root}/modules/home-manager"
          "${root}/hosts/${host.name}/home.nix" # host-specific home config
        ];
        extraSpecialArgs = {
          inherit inputs host root;
        };
      }
  )
  validatedHosts
