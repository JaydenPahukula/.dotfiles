# default user-level config for all my machines
{
  host,
  pkgs,
  ...
}: {
  config = {
    programs.home-manager.enable = true;

    nixpkgs.config.allowUnfree = true;

    home = rec {
      username = "jayden";
      homeDirectory = "/home/${username}";
      stateVersion = host.stateVersion;
    };

    home.packages = with pkgs; [
      btop
    ];

    programs.bash.enable = true;
    programs.git.enable = true;
    programs.lf.enable = true;

    home.shellAliases = {
      "open" = "xdg-open";
    };
  };
}
