# common system-level config for all my machines
{
  host,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./apps
    ./desktop.nix
    ./server.nix
    ./users.nix
  ];

  config = {
    system.stateVersion = host.stateVersion;

    networking.hostName = host.name;

    services.fwupd.enable = true;

    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.editor = false;

    i18n.defaultLocale = "en_US.UTF-8";

    networking.networkmanager.enable = true;
    systemd.services.NetworkManager-wait-online.enable = false; # disable network wait (this caused boot to be slow)

    programs.bash.enable = true;

    environment.systemPackages = with pkgs; [
      home-manager

      # common utilities
      brightnessctl
      efibootmgr
      file
      inetutils
      killall
      neofetch
      nix-tree
      openssl
      playerctl
      python312
      traceroute
      tree
      unzip
      vim
      wget
      wirelesstools
      zip
    ];

    environment.variables.EDITOR = lib.mkOverride 900 "${pkgs.vim}/bin/vim";

    # allow unfree software
    nixpkgs.config.allowUnfree = true;
    environment.variables.NIXPKGS_ALLOW_UNFREE = "1";
    # garbage collection
    nix.gc.automatic = true;
    nix.gc.dates = "weekly";
    nix.gc.options = "--delete-older-than 30d";
    # enable flakes
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    # login stuff
    services.getty.helpLine = lib.mkForce ""; # suppress nixos-help message
    services.getty.extraArgs = ["--skip-login"]; # autofill username
    services.getty.loginOptions = "-- jayden";
    # disable display managers
    services.displayManager.sddm.enable = false;
    services.xserver.displayManager.lightdm.enable = false;
  };
}
