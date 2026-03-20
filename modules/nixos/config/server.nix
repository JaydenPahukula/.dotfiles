# default system-level config for my server (headless) machines
{
  host,
  lib,
  ...
}: {
  config = lib.mkIf (host.type == "server") {
    services.openssh.enable = true;
  };
}
