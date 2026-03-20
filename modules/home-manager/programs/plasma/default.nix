# kde plasma
{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
    ./input.nix
    ./krunner.nix
    ./kscreenlocker.nix
    ./spectacle.nix
    ./wallpaper.nix
  ];

  config = lib.mkIf config.programs.plasma.enable {
    home.packages = with pkgs; [
      hackneyed
    ];

    programs.plasma = {
      overrideConfig = true;
      workspace.cursor.theme = "Hackneyed";

      shortcuts = {
        kwin = {
          "Grid View" = "";
          "Overview" = "Meta+Space";
          "Walk Through Windows of Current Application" = "";
          "Walk Through Windows of Current Application (Reverse)" = "";
        };
      };

      kwin.edgeBarrier = 50;

      # disable all panels (and delete all panels every time)
      panels = [];
      startup.desktopScript."clear-panels" = {
        runAlways = true;
        text = ''
          panels().forEach((panel) => panel.remove());
        '';
      };

      # disable hot corners
      configFile."kwinrc" = {
        "Effect-overview"."BorderActivate" = 9;
      };

      # do not restore apps/windows
      configFile."ksmserverrc" = {
        "General"."loginMode" = "emptySession";
      };

      # do not preview windows in task switcher
      configFile."kwinrc"."TabBox"."HighlightWindows" = false;

      # klipper (clipboard history)
      startup.startupScript."klipper" = {
        runAlways = true;
        text = "${pkgs.kdePackages.plasma-workspace}/bin/klipper &";
      };
      configFile."klipperrc" = {
        "General" = {
          "SyncClipboards" = false;
          "IgnoreSelection" = true;
          "IgnoreImages" = false;
          "SelectionTextOnly" = true;
        };
      };

      # disable kwallet
      configFile."kwalletrc"."Wallet" = {
        "Enabled" = false;
      };
    };
  };
}
