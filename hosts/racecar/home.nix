{
  root,
  pkgs,
  ...
}: {
  programs.waybar = {
    temp.thermal-zone = 1; # x86_pkg_temp
    gpu.hwmon-path = "/sys/class/hwmon/hwmon6/device/gpu_busy_percent";
  };

  wallpaper = "${root}/assets/wallpapers/adriano.jpg";

  programs.plasma.powerdevil.AC = {
    turnOffDisplay = {
      idleTimeout = 1800; # 30 mins
      idleTimeoutWhenLocked = 300; # 5 mins
    };
    dimDisplay = {
      enable = true;
      idleTimeout = 1740; # 29 mins
    };
    powerButtonAction = "showLogoutScreen";
    powerProfile = "performance";
  };

  home.packages = with pkgs; [
    # apps
    discord
    spotify

    # games
    prismlauncher

    alejandra
    nixd

    # utils
    nvtopPackages.amd

    nodejs_22
  ];
}
