{
  pkgs,
  lib,
  config,
  ...
}: {
  users.users."jayden" = {
    isNormalUser = true;
    description = "Jayden";
    shell = pkgs.bash;
    extraGroups =
      [
        "networkmanager"
        "wheel"
      ]
      ++ lib.optionals (config.programs.wireshark.enable) ["wireshark"]
      ++ lib.optionals (config.virtualisation.docker.enable) ["docker"];
  };
}
