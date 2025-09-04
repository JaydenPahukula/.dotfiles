{
  config,
  lib,
  ...
}: {
  options.wallpaper = lib.mkOption {
    type = lib.types.str;
    default = "";
    example = "~/Pictures/wallpaper.png";
    description = ''
      Path to wallpaper file.

      Note that the type is string, so that it will not symlink to /nix/store/.
    '';
  };

  config.programs.plasma = {
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
