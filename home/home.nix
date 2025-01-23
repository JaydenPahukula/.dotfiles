# main home configuration
{pkgs, ...}: {
  imports = [
    ./assets
    ./config/bash.nix
    ./config/chrome.nix
    ./config/colors.nix
    ./config/direnv.nix
    ./config/fonts.nix
    ./config/git.nix
    ./config/ipod.nix
    ./config/lf
    ./config/mako.nix
    ./config/plasma
    ./config/python.nix
    ./config/trash.nix
    ./config/waybar.nix
    ./config/yakuake
    ./scripts
  ];

  home = rec {
    username = "jayden";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11"; # do not change
  };

  # enable home manager
  programs.home-manager.enable = true;

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # allow certain insecure packages
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0" # obsidian needs this
  ];

  home.packages = with pkgs; [
    # apps
    beeper
    discord
    gimp
    kate
    libreoffice-qt6
    obsidian
    spotify
    vscode

    # utils
    libnotify
    wl-clipboard

    # games
    prismlauncher
    smassh
  ];
}
