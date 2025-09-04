# wired-notify config
{
  config,
  pkgs,
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

    settings = with config.colors; {
      font = "Hack Nerd Font 10";
      anchor = "top-right";
      default-timeout = "3000";
      background-color = "#${base00}";
      border-color = "#${base07}";
      border-size = "2";
      border-radius = "3";
      text-color = "#${base07}";
      progress-color = "#${base0D}";

      "urgency=critical" = {
        border-color = "#${base08}";
      };
      "app-name=Spotify" = {
        format = "<b><span foreground='#${spotify}' size='12pt'></span> %s</b>\\n%b";
      };
      "app-name=discord" = {
        format = "<b><span foreground='#${discord}' size='12pt'></span>  %s</b>\\n%b";
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
        text-color = "#${base05}";
      };
      "app-name=volume-loud" = {
        font = "Hack Nerd Font 12";
        anchor = "top-center";
        padding = "6,10";
        margin = "850";
        default-timeout = "1000";
        text-color = "#${base10}";
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
