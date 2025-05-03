{
  pkgs,
  volumeNotify,
}:
pkgs.writeShellScript "volume-up" ''
  ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%

  # send volume notification
  . ${volumeNotify}
''
