# default user-level config for my server (headless) machines
{
  host,
  lib,
  ...
}: {
  config = lib.mkIf (host.type == "server") {
    programs.trash.enable = true;
  };
}
