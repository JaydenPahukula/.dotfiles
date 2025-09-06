{pkgs, ...}:{
  home.packages = with pkgs; [
    discord
    spotify

    alejandra
    nixd
  ];
}
