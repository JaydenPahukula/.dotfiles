# nixos modules
{
  host,
  pkgs,
  ...
}: {
  imports = [
    ./apps
    ./nix.nix
    ./system.nix
    ./utils.nix
    ./users.nix
  ];

  # install home-manager
  environment.systemPackages = [
    pkgs.home-manager
  ];

  system.stateVersion = host.stateVersion;
}
