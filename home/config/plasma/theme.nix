# plasma theme
{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    hackneyed
  ];

  programs.plasma = {
    workspace.cursor.theme = "Hackneyed";

    workspace.wallpaper = config.assets.wallpaper;
    kscreenlocker.appearance.wallpaper = config.assets.wallpaper;

    # fix wallpaper
    startup.desktopScript."wallpaper_picture".runAlways = true;
  };
}
