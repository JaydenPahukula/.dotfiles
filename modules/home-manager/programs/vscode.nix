# vscode config
{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.programs.vscode.enable {
    programs.vscode = {
      mutableExtensionsDir = true;
    };
  };
}
