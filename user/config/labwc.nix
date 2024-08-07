# labwc config

{ config, lib, pkgs, ... }:

{
  programs.labwc = let

    # packages
    cliphist = "${pkgs.cliphist}/bin/cliphist";
    wl-clip-persist = "${pkgs.wl-clip-persist}/bin/wl-clip-persist";
    wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";
    wl-paste = "${pkgs.wl-clipboard}/bin/wl-paste";
    rofi = "${pkgs.rofi}/bin/rofi";
    grim = "${pkgs.grim}/bin/grim";
    slurp = "${pkgs.slurp}/bin/slurp";
    amixer = "${pkgs.alsa-utils}/bin/amixer";
    swayidle = "${pkgs.swayidle}/bin/swayidle";
    swaylock = "${pkgs.swaylock-effects}/bin/swaylock";
    wlopm = "${pkgs.wlopm}/bin/wlopm";

    # scripts
    appLauncherScript = pkgs.writeShellScript "applauncher.sh" ''
      if pgrep -x rofi; then
        killall rofi
      else
        ${rofi} -show drun -show-icons
      fi
    '';
    clipboardHistoryScript = pkgs.writeShellScript "clipboardhistory.sh" ''
      ${cliphist} list | ${rofi} -dmenu -p 'clipboard' | ${cliphist} decode | ${wl-copy}
    '';
    screenshotScript = pkgs.writeShellScript "screenshot.sh" ''
      sh -c '${grim} -g "$(${slurp} -d)" "$HOME"/Pictures/screenshots/screenshot_"$(date +%Y%m%d_%Hh%Mm%Ss)".png'
    '';
    swayidleScript = pkgs.writeShellScript "swayidle.sh" ''
      ${swayidle} -w \
        timeout 300 '${swaylock} -f' \
        timeout 600 '${wlopm} --off \*' \
          resume '${wlopm} --on \*' \
        timeout 1200 'systemctl suspend'
    '';

  in {
    enable = true;

    config = {

      windowSwitcher = {
        show = true;
        preview = false;
        outlines = true;
        allWorkspaces = false;
        fields = [
          { content="trimmed_identifier"; width="50%"; }
          { content="title"; width="50%"; }
        ];
      };

      focus.raiseOnFocus = true;

      keyboard.keybinds = [
        { key="A-Tab"; actions = [
          { name="NextWindow"; }
        ];}
        { key="A-Return"; actions = [
          { name="Execute"; command="konsole"; }
        ];}
        { key="A-F4"; actions = [
          { name="Close"; }
        ];}
        { key="A-Super_L"; actions = [
          { name="Execute"; command="${appLauncherScript}"; }
        ];}
        { key="W-v"; actions = [
          { name="Execute"; command="${clipboardHistoryScript}"; }
        ];}
        { key="F12"; actions = [
          { name="Execute"; command="yakuake"; }
        ];}
        { key="XF86AudioMedia"; actions = [
          { name="Execute"; command="yakuake"; }
        ];}
        { key="XF86_AudioLowerVolume"; actions = [
          { name="Execute"; command="${amixer} sset Master 5%-"; }
        ];}
        { key="XF86_AudioRaiseVolume"; actions = [
          { name="Execute"; command="${amixer} sset Master 5%+"; }
        ];}
        { key="XF86_AudioMute"; actions = [
          { name="Execute"; command="${amixer} sset Master toggle"; }
        ];}
        { key="XF86_MonBrightnessUp"; actions = [
          { name="Execute"; command="brightnessctl set 5%+"; }
        ];}
        { key="XF86_MonBrightnessDown"; actions = [
          { name="Execute"; command="brightnessctl set 5%-"; }
        ];}
        { key="XF86_AudioPlay"; actions = [
          { name="Execute"; command="playerctl play-pause"; }
        ];}
        { key="XF86_AudioNext"; actions = [
          { name="Execute"; command="playerctl next"; }
        ];}
        { key="XF86_AudioPrev"; actions = [
          { name="Execute"; command="playerctl previous"; }
        ];}
        { key="Print"; actions = [
          { name="Execute"; command="${screenshotScript}"; }
        ];}
        { key="W-l"; actions = [
          { name="Execute"; command="${swaylock} -f"; }
        ];}
      ];

      mouse.scrollFactor = 0.5;

      libinput = {
        "default" = {
          naturalScroll = false;
          pointerSpeed = 0.01;
          accelProfile = "flat";
          tap = true;
          tapAndDrag = false;
        };
        "touchpad" = {
          naturalScroll = true;
          pointerSpeed = 0.5;
          accelProfile = "flat";
          tapAndDrag = false;
        };
      };

      windowRules = [
        {
          criteria = { identifier="*"; };
          actions = [
            { name="UnMaximize"; direction="both"; }
          ];
        }
        {
          criteria = { identifier="org.kde.yakuake"; };
          properties = {
            skipTaskbar = true;
            skipWindowSwitcher = true;
            fixedPosition = true;
          };
          actions = [
            { name="MoveToEdge"; direction="up"; snapWindows="no"; }
          ];
        }
      ];

    };

    autostart = [
      "${pkgs.swaybg}/bin/swaybg -i '${config.assets.wallpaper}'"
      "${pkgs.waybar}/bin/waybar"
      "${pkgs.yakuake}/bin/yakuake"
      "${pkgs.wlr-randr}/bin/wlr-randr --output eDP-1 --scale 1.3"
      "${swayidleScript}"

      # clipboard persistance
      "${wl-clip-persist} --clipboard both"
      "${wl-paste} --type text --watch ${cliphist} store"
      "${wl-paste} --type image --watch ${cliphist} store"
    ];
  };
}
