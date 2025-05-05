{
  pkgs,
  brightnessNotify,
}:
pkgs.writeShellScript "brightness-up" ''
  # increment brightness
  ${pkgs.brightnessctl}/bin/brightnessctl set +5%

  # send volume notification
  . ${brightnessNotify}
''
