{
  root,
  pkgs,
  ...
}: {
  programs.waybar = {
    temp.thermal-zone = 1; # x86_pkg_temp
    gpu.hwmon-path = "/sys/class/hwmon/hwmon6/device/gpu_busy_percent";
  };

  programs.plasma.wallpaper = "${root}/assets/wallpapers/adriano.jpg";

  programs.plasma.powerdevil.AC = {
    turnOffDisplay = {
      idleTimeout = 1800; # 30 mins
      idleTimeoutWhenLocked = "immediately";
    };
    dimDisplay = {
      enable = true;
      idleTimeout = 1740; # 29 mins
    };
    powerButtonAction = "showLogoutScreen";
    powerProfile = "performance";
  };

  programs.discord.enable = true;
  programs.google-chrome.enable = true;

  programs.direnv.enable = true;
  programs.pypy.enable = true;

  home.packages = with pkgs; [
    # apps
    spotify

    # games
    prismlauncher

    alejandra
    nixd

    # utils
    nvtopPackages.amd

    nodejs_22
  ];

  programs.ssh.enable = true;
  programs.ssh.matchBlocks = {
    "radar" = {
      hostname = "192.168.0.99";
      user = "jayden";
      identityFile = "~/.ssh/id_ed25519";
      identitiesOnly = true;
    };
  };
}
