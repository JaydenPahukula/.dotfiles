# dunst config
{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    hack-font
    jq # missing dependency
  ];

  services.dunst = {
    enable = true;
  };

  xdg.configFile."dunst/dunstrc".text = with config.colorScheme.palette; ''
    [global]
    font = "Hack 10"
    frame_width = 2
    gap_size = 8
    offset = "10x10"
    origin = "top-right"
    show_indicators = false

    [urgency_low]
    background = "#${base00}"
    foreground = "#${base07}"
    timeout = "4s"

    [urgency_normal]
    background = "#${base00}"
    foreground = "#${base07}"
    timeout = "4s"

    [spotify]
    desktop_entry = Spotify
    frame_color = "#${spotify}"

    [discord]
    desktop_entry = discord
    frame_color = "#7289DA"
  '';
}
