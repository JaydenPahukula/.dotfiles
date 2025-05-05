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
      echo -e "\nLaunching KDE Plasma...\n"
      startplasma-wayland
      logout
    else
      echo
    fi
  ''}";
}
