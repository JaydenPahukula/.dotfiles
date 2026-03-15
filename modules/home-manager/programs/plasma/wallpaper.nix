{
  config,
  lib,
  ...
}: {
  options.wallpaper = lib.mkOption {
    type = lib.types.nullOr lib.types.path;
    default = null;
    example = ./Pictures/wallpaper.png;
    description = ''
      Path to wallpaper file.

      You may need to log out and in to refresh.
    '';
  };

  config.programs.plasma = lib.mkIf (config.wallpaper != null) {
    workspace.wallpaper = config.wallpaper;

    # fix wallpaper issues
    startup.desktopScript."wallpaper_picture".runAlways = true;
  };

  # leaving this here just in case
  # # symlink wallpapers to ~/Pictures/wallpapers
  # home.activation.wallpapers = lib.hm.dag.entryAfter ["writeBoundary"] ''
  #   $DRY_RUN_CMD mkdir -p ${home}/Pictures/wallpapers;
  #   $DRY_RUN_CMD ln -s ${wallpaperDir}/*.png ${home}/Pictures/wallpapers/ >/dev/null 2>&1;
  # '';
}
