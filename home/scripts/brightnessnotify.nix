{pkgs}: let
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  notify-send = "${pkgs.libnotify}/bin/notify-send";
in
  pkgs.writeShellScript "brightness-notify" ''

    ID_FILE=$XDG_CONFIG_HOME/transient-notification-id

    # check last transient notification id
    id=0
    if [[ -s $ID_FILE ]]; then
      id=$(cat $ID_FILE)
    fi

    brightness=$(( 100 * $(${brightnessctl} get) / $(${brightnessctl} max) ))

    # send notification
    ${notify-send} -p -a "brightness" -r "$id" -h int:value:$brightness " $brightness%" > $ID_FILE
  ''
