{
  pkgs,
  volumeNotify,
}:
pkgs.writeShellScript "volume-mute" ''
  ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle

  # send volume notification
  . ${volumeNotify}
''
