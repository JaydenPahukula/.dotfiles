# login stuff
{
  lib,
  pkgs,
  ...
}: {
  # disable display managers
  services.displayManager.sddm.enable = false;
  services.xserver.displayManager.lightdm.enable = false;
  # agetty
  services.getty = {
    # suppress nixos-help message
    helpLine = lib.mkForce "";
    # autofill username
    extraArgs = ["--skip-login"];
    loginOptions = "-- jayden";
  };
  # start wayland on login (only on tty1)
  programs.bash.loginShellInit = ". ${pkgs.writeShellScript "start-plasma" ''
    if [[ $(tty) == /dev/tty1 ]]; then
      echo "Launching KDE Plasma..."
      startplasma-wayland &
    fi
    echo
  ''}";
}
