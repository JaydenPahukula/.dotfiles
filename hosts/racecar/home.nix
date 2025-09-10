{pkgs, ...}: {
  # set waybar temp to x86_pkg_temp
  programs.waybar.temp.thermal-zone = 1;

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
