# wired-notify config
{
  pkgs,
  colors,
  ...
}: {
  home.packages = with pkgs; [
    nerd-fonts.hack
  ];

  # start mako on boot
  programs.plasma.startup.startupScript."mako" = {
    runAlways = true;
    text = "${pkgs.mako}/bin/mako &";
  };

  # mako config
  services.mako = {
    enable = true;

    settings = {
      font = "Hack Nerd Font 10";
      anchor = "top-right";
      default-timeout = "3000";
      background-color = "#${colors.base00}";
      border-color = "#${colors.base07}";
      border-size = "2";
      border-radius = "3";
      text-color = "#${colors.base07}";
      progress-color = "#${colors.base0D}";
    };

    criterias = {
      "urgency=critical" = {
        border-color = "#${colors.base08}";
      };
      "app-name=Spotify" = {
        format = "<b><span foreground='#${colors.spotify}' size='12pt'></span> %s</b>\\n%b";
      };
      "app-name=discord" = {
        format = "<b><span foreground='#${colors.discord}' size='12pt'></span>  %s</b>\\n%b";
      };
      "app-name=volume" = {
        font = "Hack Nerd Font 12";
        anchor = "top-center";
        padding = "6,10";
        margin = "850";
        default-timeout = "1000";
      };
      "app-name=volume-muted" = {
        font = "Hack Nerd Font 12";
        anchor = "top-center";
        padding = "6,10";
        margin = "850";
        default-timeout = "1000";
        text-color = "#${colors.base05}";
      };
      "app-name=volume-loud" = {
        font = "Hack Nerd Font 12";
        anchor = "top-center";
        padding = "6,10";
        margin = "850";
        default-timeout = "1000";
        text-color = "#${colors.base10}";
      };
      "app-name=brightness" = {
        font = "Hack Nerd Font 12";
        anchor = "top-center";
        padding = "6,10";
        margin = "850";
        default-timeout = "1000";
      };
    };
  };
}
