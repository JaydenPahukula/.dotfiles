{lib, ...}: {
  options.wallpaper = lib.mkOption {
    type = lib.types.str;
    default = "";
    example = "~/Pictures/wallpaper.png";
    description = ''
      Path to wallpaper file.

      Note that the type is string, so that it will not symlink to /nix/store/.
    '';
  };
}
