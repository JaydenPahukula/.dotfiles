{
  config,
  lib,
  pkgs,
  ...
}: {
  options.programs.python.enable = lib.mkEnableOption "Python (3.12)";
  options.programs.pypy.enable = lib.mkEnableOption "Pypy";

  config = {
    home.packages =
      lib.optionals config.programs.python.enable [pkgs.python312]
      ++ lib.optionals config.programs.pypy.enable [pkgs.pypy3];

    home.shellAliases = {
      py = lib.mkIf config.programs.python.enable "python3.12";
      pypy = lib.mkIf config.programs.pypy.enable "pypy3";
    };
  };
}
