{...}:{
  imports=[
    ./hardware-configuration.nix
  ];

  time.timeZone = "America/Chicago";

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  programs.steam.enable = true;
}
