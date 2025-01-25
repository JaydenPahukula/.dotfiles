{
  config,
  lib,
  ...
}: let
  wallpaperDir = ./.;
  home = config.home.homeDirectory;
in {
  # symlink wallpapers to ~/Pictures/wallpapers
  home.activation.wallpapers = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD mkdir -p ${home}/Pictures/wallpapers;
    $DRY_RUN_CMD ln -s ${wallpaperDir}/*.png ${home}/Pictures/wallpapers/ >/dev/null 2>&1;
  '';

  # set wallpaper
  wallpaper = "${home}/Pictures/wallpapers/wallpaper.png";
}
