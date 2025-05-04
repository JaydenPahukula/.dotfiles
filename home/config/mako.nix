# wired-notify config
{
  pkgs,
  colors,
  ...
}: {
  home.packages = with pkgs; [
    hack-font
  ];

  # turn off plasma notifications
  programs.plasma.configFile."plasmarc"."OSD" = {
    "Enabled" = false;
  };

  # start mako on boot
  programs.plasma.startup.startupScript."mako" = {
    runAlways = true;
    text = "${pkgs.mako}/bin/mako &";
  };

  # mako config
  services.mako = {
    enable = true;

    settings = {
      anchor = "top-right";
      default-timeout = "3000";
      background-color = "#${colors.base00}";
      border-color = "#${colors.base07}";
      border-size = "2";
      border-radius = "3";
      text-color = "#${colors.base07}";
      outer-margin = "0";
    };

    criterias = {
      "app-name=volume" = {
        anchor = "bottom-center";
        outer-margin = "200";
        default-timeout = "1000";
      };
      "app-name=volume-muted" = {
        anchor = "bottom-center";
        outer-margin = "200";
        default-timeout = "1000";
        text-color = "#${colors.base05}";
      };
      "app-name=volume-loud" = {
        anchor = "bottom-center";
        outer-margin = "200";
        default-timeout = "1000";
        text-color = "#${colors.base08}";
      };
    };
  };
}
