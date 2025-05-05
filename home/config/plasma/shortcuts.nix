# plasma shortcuts
{scripts, ...}: {
  programs.plasma = {
    shortcuts = {
      kwin = {
        "Grid View" = "";
        "Overview" = "Meta+Space";
      };
    };
    hotkeys.commands = {
      "volume-up" = {
        command = "${scripts.volumeUp}";
        key = "Volume Up";
      };
      "volume-down" = {
        command = "${scripts.volumeDown}";
        key = "Volume Down";
      };
      "volume-mute" = {
        command = "${scripts.volumeMute}";
        key = "Volume Mute";
      };
      "brightness-up" = {
        command = "${scripts.brightnessUp}";
        key = "Monitor Brightness Up";
      };
      "brightness-down" = {
        command = "${scripts.brightnessDown}";
        key = "Monitor Brightness Down";
      };
    };
  };
}
