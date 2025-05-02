# main home configuration
{pkgs, ...}: {
  imports = [
    ./config/bash.nix
    ./config/chrome.nix
    ./config/colors.nix
    ./config/direnv.nix
    ./config/dunst.nix
    ./config/fonts.nix
    ./config/git.nix
    ./config/ipod.nix
    ./config/lf
    ./config/plasma
    ./config/python.nix
    ./config/trash.nix
    ./config/vscode.nix
    ./config/waybar
    ./config/yakuake
    ./modules
    ./scripts
    ./wallpaper
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
    kdePackages.kate
    libreoffice-qt6
    obsidian
    postman
    spotify

    # utils
    libnotify
    wl-clipboard
    btop

    # games
    prismlauncher
    smassh
  ];
}
