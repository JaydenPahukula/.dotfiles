{pkgs, ...}:{
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
