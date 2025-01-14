# defines asset paths, accessible throughout the config as `config.assets`.
{lib, ...}:
with lib; {
  options.assets = mkOption {
    type = types.attrsOf types.path;
    default = {};
    example = literalExpression {myImg = "./img.png";};
    description = "A collection of paths to assets.";
  };
}
