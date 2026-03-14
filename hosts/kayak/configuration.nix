# kayak nixos configuration
{inputs, ...}: {
  imports = [
    inputs.nixos-hardware.nixosModules.framework-11th-gen-intel
    ./hardware-configuration.nix
  ];

  # enable fingerprint
  services.fprintd.enable = true;

  # power
  services.logind.settings.Login = {
    HandleLidSwitch = "hibernate";
    HandlePowerKey = "ignore";
  };

  time.timeZone = "America/Chicago";

  programs.wireshark.enable = true;

  programs.sober.enable = true;
}
