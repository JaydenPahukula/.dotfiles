# trash config
{
  config,
  lib,
  pkgs,
  ...
}: {
  options.programs.trash.enable = lib.mkEnableOption "Trashy";

  config = lib.mkIf config.programs.trash.enable {
    home.packages = with pkgs; [trashy];

    home.shellAliases = {
      # alias to undo the last trash operation
      untrash = "trash restore --force -r 0";
    };
  };
}
