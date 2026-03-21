# default user-level config for my server (headless) machines
{
  host,
  lib,
  ...
}: {
  config = lib.mkIf (host.type == "server") {
    programs.ssh.enable = true;
    programs.ssh.enableDefaultConfig = false;
    programs.trash.enable = true;
  };
}
