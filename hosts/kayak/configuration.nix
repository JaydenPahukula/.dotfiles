# kayak nixos configuration
{inputs, ...}: {
  imports = [
    inputs.nixos-hardware.nixosModules.framework-11th-gen-intel
    ./hardware-configuration.nix
  ];

  # enable fingerprint
  services.fprintd.enable = true;

  # power
  services.logind.lidSwitch = "hibernate";
  services.logind.powerKey = "ignore";

  time.timeZone = "America/Chicago";

  programs.wireshark.enable = true;

  programs.sober.enable = true;
}
