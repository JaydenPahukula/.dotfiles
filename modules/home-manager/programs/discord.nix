# discord config
{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.programs.discord.enable {
    programs.discord.settings = {
      "DANGEROUS_ENABLE_DEVTOOLS_ONLY_ENABLE_IF_YOU_KNOW_WHAT_YOURE_DOING" = false;
      "MINIMIZE_TO_TRAY" = false;
      "OPEN_ON_STARTUP" = false;
      "SKIP_HOST_UPDATE" = true;
    };
  };
}
