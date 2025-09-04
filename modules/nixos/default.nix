# nixos modules
{...}: {
  imports = [
    ./nix.nix
    ./system.nix
    ./utils.nix
    ./users.nix
  ];

  system.stateVersion = "23.11"; # IMPORTANT: DO NOT CHANGE
}
