{
  pkgs,
  brightnessNotify,
}:
pkgs.writeShellScript "brightness-down" ''
  # decrement brightness
  ${pkgs.brightnessctl}/bin/brightnessctl set 5%-

  # send volume notification
  . ${brightnessNotify}
''
