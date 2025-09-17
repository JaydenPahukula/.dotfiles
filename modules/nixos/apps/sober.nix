{
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  options.programs.sober.enable = lib.mkEnableOption "Enable Sober (from flatpak, using nix-flatpak)";

  config = lib.mkIf config.programs.sober.enable {
    services.flatpak = {
      enable = true;
      update.auto.enable = false;
      packages = [
        {
          appId = "org.vinegarhq.Sober";
          origin = "flathub";
        }
      ];
    };
  };
}
