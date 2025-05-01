# main configuration
{pkgs, ...}: {
  imports = [
    ./config/bluetooth.nix
    ./config/docker.nix
    ./config/garbage.nix
    ./config/locale.nix
    ./config/login.nix
    ./config/plasma.nix
    ./config/power.nix
    ./config/wireshark.nix
    ./hardware-configuration.nix
  ];

  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "23.11"; # do not change

  # framework hardware stuff
  services.fwupd.enable = true;

  # hostname
  networking.hostName = "nixos";

  # enable networking
  networking.networkmanager.enable = true;

  # enable X11 windowing system
  services.xserver.enable = true;

  # desktop portals
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  # enable CUPS to print documents.
  services.printing.enable = true;

  # enable sound with pipewire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # enable fingerprint
  services.fprintd.enable = true;

  # enable flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # X11 keymap
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # user account
  users.users."jayden" = {
    isNormalUser = true;
    description = "Jayden";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # disable network wait service (this caused boot to be slow)
  systemd.services.NetworkManager-wait-online.enable = false;

  services.usbmuxd.enable = true;

  # make apps not blurry
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # system packages
  environment.systemPackages = with pkgs; [
    # apps
    google-chrome

    # utils
    brightnessctl
    file
    killall
    neofetch
    playerctl
    python312
    traceroute
    unzip
    vim
    wget
    wirelesstools
    zip

    # home manager
    home-manager

    # formatter
    alejandra

    # nix lsp
    nixd
  ];

  # enable git
  programs.git.enable = true;

  # environment variables
  environment.sessionVariables = {
    # make default editor vim
    EDITOR = "vim";

    # xdg stuff
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
  };
}
