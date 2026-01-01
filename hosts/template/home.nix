{
  root,
  pkgs,
  ...
}: {
  wallpaper = "${root}/assets/wallpapers/*.jpg";

  home.packages = with pkgs; [
    # add packages here
  ];
}
