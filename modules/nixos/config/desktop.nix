# default system-level config for my desktop machines
{
  host,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (host.type == "desktop") {
    services.printing.enable = true;

    services.xserver.enable = true;
    services.xserver.xkb.layout = "us";
    services.xserver.xkb.variant = "";

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

    # kde plasma
    services.desktopManager.plasma6.enable = true;
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      ark
      discover
      dolphin-plugins
      elisa
      gwenview
      khelpcenter
      krdp
      okular
      oxygen
    ]; # see https://github.com/NixOS/nixpkgs/blob/nixos-25.05/nixos/modules/services/desktop-managers/plasma6.nix#L157
    # start plasma on login (only on tty1)
    programs.bash.loginShellInit = ". ${pkgs.writeShellScript "start-plasma" ''
      if [[ $(tty) == /dev/tty1 ]]; then
        echo -e "\nLaunching KDE Plasma...\n"
        ${pkgs.kdePackages.plasma-workspace}/bin/startplasma-wayland
        logout
      fi
    ''}";

    # audio stuff
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire.enable = true;
    services.pipewire.alsa.enable = true;
    services.pipewire.alsa.support32Bit = true;
    services.pipewire.pulse.enable = true;
    services.pipewire.jack.enable = true;
  };
}
