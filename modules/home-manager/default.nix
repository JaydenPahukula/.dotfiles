# home manager modules
{host, ...}: {
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
    stateVersion = host.stateVersion;
  };
}
