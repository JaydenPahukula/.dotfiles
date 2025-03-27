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
    icon_path="/run/current-system/sw/share/icons/hicolor/32x32/actions:/run/current-system/sw/share/icons/hicolor/32x32/animations:/run/current-system/sw/share/icons/hicolor/32x32/apps:/run/current-system/sw/share/icons/hicolor/32x32/categories:/run/current-system/sw/share/icons/hicolor/32x32/devices:/run/current-system/sw/share/icons/hicolor/32x32/emblems:/run/current-system/sw/share/icons/hicolor/32x32/emotes:/run/current-system/sw/share/icons/hicolor/32x32/filesystem:/run/current-system/sw/share/icons/hicolor/32x32/intl:/run/current-system/sw/share/icons/hicolor/32x32/legacy:/run/current-system/sw/share/icons/hicolor/32x32/mimetypes:/run/current-system/sw/share/icons/hicolor/32x32/places:/run/current-system/sw/share/icons/hicolor/32x32/status:/run/current-system/sw/share/icons/hicolor/32x32/stock:/home/jayden/.nix-profile/share/icons/hicolor/32x32/actions:/home/jayden/.nix-profile/share/icons/hicolor/32x32/animations:/home/jayden/.nix-profile/share/icons/hicolor/32x32/apps:/home/jayden/.nix-profile/share/icons/hicolor/32x32/categories:/home/jayden/.nix-profile/share/icons/hicolor/32x32/devices:/home/jayden/.nix-profile/share/icons/hicolor/32x32/emblems:/home/jayden/.nix-profile/share/icons/hicolor/32x32/emotes:/home/jayden/.nix-profile/share/icons/hicolor/32x32/filesystem:/home/jayden/.nix-profile/share/icons/hicolor/32x32/intl:/home/jayden/.nix-profile/share/icons/hicolor/32x32/legacy:/home/jayden/.nix-profile/share/icons/hicolor/32x32/mimetypes:/home/jayden/.nix-profile/share/icons/hicolor/32x32/places:/home/jayden/.nix-profile/share/icons/hicolor/32x32/status:/home/jayden/.nix-profile/share/icons/hicolor/32x32/stock:/nix/store/gvrn8zjc63r1qrd0hwgdwxd4hc8kja08-hicolor-icon-theme-0.18/share/icons/hicolor/32x32/actions:/nix/store/gvrn8zjc63r1qrd0hwgdwxd4hc8kja08-hicolor-icon-theme-0.18/share/icons/hicolor/32x32/animations:/nix/store/gvrn8zjc63r1qrd0hwgdwxd4hc8kja08-hicolor-icon-theme-0.18/share/icons/hicolor/32x32/apps:/nix/store/gvrn8zjc63r1qrd0hwgdwxd4hc8kja08-hicolor-icon-theme-0.18/share/icons/hicolor/32x32/categories:/nix/store/gvrn8zjc63r1qrd0hwgdwxd4hc8kja08-hicolor-icon-theme-0.18/share/icons/hicolor/32x32/devices:/nix/store/gvrn8zjc63r1qrd0hwgdwxd4hc8kja08-hicolor-icon-theme-0.18/share/icons/hicolor/32x32/emblems:/nix/store/gvrn8zjc63r1qrd0hwgdwxd4hc8kja08-hicolor-icon-theme-0.18/share/icons/hicolor/32x32/emotes:/nix/store/gvrn8zjc63r1qrd0hwgdwxd4hc8kja08-hicolor-icon-theme-0.18/share/icons/hicolor/32x32/filesystem:/nix/store/gvrn8zjc63r1qrd0hwgdwxd4hc8kja08-hicolor-icon-theme-0.18/share/icons/hicolor/32x32/intl:/nix/store/gvrn8zjc63r1qrd0hwgdwxd4hc8kja08-hicolor-icon-theme-0.18/share/icons/hicolor/32x32/legacy:/nix/store/gvrn8zjc63r1qrd0hwgdwxd4hc8kja08-hicolor-icon-theme-0.18/share/icons/hicolor/32x32/mimetypes:/nix/store/gvrn8zjc63r1qrd0hwgdwxd4hc8kja08-hicolor-icon-theme-0.18/share/icons/hicolor/32x32/places:/nix/store/gvrn8zjc63r1qrd0hwgdwxd4hc8kja08-hicolor-icon-theme-0.18/share/icons/hicolor/32x32/status:/nix/store/gvrn8zjc63r1qrd0hwgdwxd4hc8kja08-hicolor-icon-theme-0.18/share/icons/hicolor/32x32/stock"

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
