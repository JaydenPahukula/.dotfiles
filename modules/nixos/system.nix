# default system config
{
  pkgs,
  lib,
  name,
  ...
}: {
  networking.hostName = name;

  services.fwupd.enable = true;

  # audio stuff
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.printing.enable = true;

  boot.loader.systemd-boot = {
    enable = true;
    editor = false;
  };

  boot.loader.efi.canTouchEfiVariables = true;

  i18n.defaultLocale = "en_US.UTF-8";

  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false; # disable network wait (this caused boot to be slow)

  # desktop portals
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # makes apps not blurry on wayland

    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    XDG_BIN_HOME = "$HOME/.local/bin";
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    # see https://github.com/NixOS/nixpkgs/blob/nixos-25.05/nixos/modules/services/desktop-managers/plasma6.nix#L157
    ark
    discover
    dolphin-plugins
    elisa
    gwenview
    khelpcenter
    krdp
    okular
    oxygen
  ];

  # disable display managers
  services.displayManager.sddm.enable = false;
  services.xserver.displayManager.lightdm.enable = false;
  # login stuff
  services.getty = {
    helpLine = lib.mkForce ""; # suppress nixos-help message
    # autofill username
    extraArgs = ["--skip-login"];
    loginOptions = "-- jayden";
  };
  # start plasma on login (only on tty1)
  programs.bash.loginShellInit = ". ${pkgs.writeShellScript "start-plasma" ''
    if [[ $(tty) == /dev/tty1 ]]; then
      echo -e "\nLaunching KDE Plasma...\n"
      startplasma-wayland
      logout
    else
      echo
    fi
  ''}";
}
