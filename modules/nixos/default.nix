# nixos modules
{pkgs, ...}: {
  imports = [
    ./nix.nix
    ./system.nix
    ./utils.nix
    ./users.nix
  ];

  # install home-manager
  environment.systemPackages = [
    pkgs.home-manager
  ];

  system.stateVersion = "23.11"; # IMPORTANT: DO NOT CHANGE
}
