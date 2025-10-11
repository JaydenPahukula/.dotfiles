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
