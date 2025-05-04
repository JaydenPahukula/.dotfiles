{
  pkgs,
  volumeNotify,
}:
pkgs.writeShellScript "volume-up" ''
  # increment volume
  ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%

  # unmute
  ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ 0

  # send volume notification
  . ${volumeNotify}
''
