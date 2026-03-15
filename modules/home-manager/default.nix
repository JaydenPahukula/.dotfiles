# home manager modules
{...}: {
  imports = [
    ./apps
    ./programs
    ./services
    ./colors.nix
    ./fonts.nix
  ];

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  home = rec {
    username = "jayden";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11"; # DO NOT CHANGE!
  };
}
