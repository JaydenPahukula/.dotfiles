{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  options.sops.enable = lib.mkEnableOption "Sops";

  config = lib.mkIf config.sops.enable {
    environment.systemPackages = [pkgs.sops];

    environment.variables.SOPS_AGE_KEY_FILE = config.sops.age.keyFile;

    sops.age.keyFile = lib.mkDefault "/var/lib/sops-nix/key.txt";
    sops.age.generateKey = lib.mkDefault true;
  };
}
