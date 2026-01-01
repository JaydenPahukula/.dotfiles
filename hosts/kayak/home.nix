# kayak home manager configuration
{
  pkgs,
  root,
  ...
}: {
  wallpaper = "${root}/assets/wallpapers/windrises.png";

  programs.waybar.temp.thermal-zone = 2; # SEN5

  # set default display scale/position
  programs.plasma.startup.startupScript."displaySetup" = {
    runAlways = true;
    text = let
      kscreen-doctor = "${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor";
    in ''
      ${kscreen-doctor} \
        output.1.scale.1.3 \
        output.1.position.0,0 \
      ${kscreen-doctor} \
        output.2.scale.1 \
        output.2.position.-1920,0 \
    '';
  };

  # sleep stuff
  programs.plasma.powerdevil = rec {
    AC = {
      autoSuspend = {
        action = "sleep";
        idleTimeout = 1800; # 30 mins
      };
      turnOffDisplay = {
        idleTimeout = 1500; # 25 mins
        idleTimeoutWhenLocked = "immediately";
      };
      dimDisplay = {
        enable = true;
        idleTimeout = 1440; # 24 mins
      };
      powerButtonAction = "showLogoutScreen";
      whenLaptopLidClosed = "sleep";
      inhibitLidActionWhenExternalMonitorConnected = false;
    };
    battery = {
      autoSuspend = {
        action = "sleep";
        idleTimeout = 1200; # 20 mins
      };
      turnOffDisplay = {
        idleTimeout = 600; # 10 mins
        idleTimeoutWhenLocked = "immediately";
      };
      dimDisplay = {
        enable = true;
        idleTimeout = 540; # 9 mins
      };
      powerButtonAction = "showLogoutScreen";
      whenLaptopLidClosed = "sleep";
      inhibitLidActionWhenExternalMonitorConnected = false;
    };
    # same config for low battery
    lowBattery = battery;
  };

  home.packages = with pkgs; [
    # apps
    discord
    gimp
    libreoffice-qt6
    postman
    spotify

    alejandra
    nixd

    # games
    prismlauncher
    smassh

    nodejs_22
  ];
}
