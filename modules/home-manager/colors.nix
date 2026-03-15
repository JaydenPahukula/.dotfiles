{
  lib,
  root,
  ...
}: {
  options.colors = lib.mkOption {
    type = lib.types.attrsOf lib.types.str;
    default = import "${root}/assets/colorschemes/default.nix";
    description = ''
      Attribute set of hexidecimal colors (capitalized, no prefix).
      Any key can be defined, but you should define at least `base00` through `base17`.
    '';
  };
}
