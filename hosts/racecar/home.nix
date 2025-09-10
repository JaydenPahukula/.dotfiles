{pkgs, ...}: {
  programs.waybar = {
    temp.thermal-zone = 1; # x86_pkg_temp
    gpu.hwmon-path = "/sys/class/hwmon/hwmon6/device/gpu_busy_percent";
  };

  home.packages = with pkgs; [
    # apps
    discord
    spotify

    alejandra
    nixd

    # utils
    nvtopPackages.amd
  ];
}
