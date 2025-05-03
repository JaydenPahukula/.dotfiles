{pkgs}: let
  pactl = "${pkgs.pulseaudio}/bin/pactl";
  paplay = "${pkgs.pulseaudio}/bin/paplay";
  notify-send = "${pkgs.libnotify}/bin/notify-send";
in
  pkgs.writeShellScript "volume-notify" ''
    # send notification
    volume=$(${pactl} get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -1 | cut -d'%' -f1)
    muted=$(${pactl} get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
    if [[ $muted == "no" ]]; then
      ${notify-send} -h int:value:$volume -h string:desktop-entry:volume "Volume: $volume"
    else
      ${notify-send} -h int:value:$volume -h string:desktop-entry:volume-muted "Volume: $volume"
    fi

    # play sound
    # (https://invent.kde.org/plasma/ocean-sound-theme/-/tree/master/ocean/stereo?ref_type=heads)
    ${paplay} ${pkgs.kdePackages.ocean-sound-theme}/share/sounds/ocean/stereo/audio-volume-change.oga
  ''
