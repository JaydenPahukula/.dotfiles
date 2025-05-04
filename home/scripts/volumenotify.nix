{pkgs}: let
  pactl = "${pkgs.pulseaudio}/bin/pactl";
  paplay = "${pkgs.pulseaudio}/bin/paplay";
  notify-send = "${pkgs.libnotify}/bin/notify-send";
in
  pkgs.writeShellScript "volume-notify" ''

    ID_FILE=$XDG_CONFIG_HOME/transient-notification-id

    # check last transient notification id
    id=0
    if [[ -s $ID_FILE ]]; then
      id=$(cat $ID_FILE)
    fi

    volume=$(${pactl} get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -1 | cut -d'%' -f1)
    muted=$(${pactl} get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

    if [[ $muted == "yes" ]]; then
      summary="  $volume%"
      appname="volume-muted"
    elif [[ $volume -eq 0 ]]; then
      summary="  $volume%";
      appname="volume-muted"
    elif [[ $volume -lt 30 ]]; then
      summary="  $volume%";
      appname="volume"
    elif [[ $volume -lt 100 ]]; then
      summary="  $volume%";
      appname="volume"
    else
      summary="  $volume%";
      appname="volume-loud"
    fi

    # send notification
    ${notify-send} -p -a "$appname" -r "$id" -h int:value:$volume "$summary" > $ID_FILE

    # play sound
    # (https://invent.kde.org/plasma/ocean-sound-theme/-/tree/master/ocean/stereo?ref_type=heads)
    ${paplay} ${pkgs.kdePackages.ocean-sound-theme}/share/sounds/ocean/stereo/audio-volume-change.oga
  ''
