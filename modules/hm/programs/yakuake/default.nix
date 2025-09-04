# yakuake config
# look here for settings: https://github.com/KDE/yakuake/blob/master/app/config/yakuake.kcfg
{
  config,
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    kdePackages.yakuake
    (import ./yakuake-session.nix {inherit pkgs;}) # import yakuake-session script
    # font
    nerd-fonts.dejavu-sans-mono
  ];

  # override default desktop entry
  xdg.desktopEntries."org.kde.yakuake" = {
    name = "Yakuake";
    genericName = "Drop-down Terminal";
    comment = "A drop-down terminal emulator based on KDE Konsole technology.";
    exec = "yakuake-session";
    icon = "yakuake";
    settings = {
      X-DBUS-StartupType = "Unique";
      X-DBUS-ServiceName = "org.kde.yakuake";
      DBusActivatable = "true";
    };
    startupNotify = false;
  };

  # make yakuake the default terminal
  programs.plasma.configFile."kdeglobals"."General" = {
    "TerminalApplication" = "yakuake-session";
    "TerminalService" = "org.kde.yakuake.desktop";
  };
  home.sessionVariables = {
    TERMINAL = "yakuake";
  };

  # start yakuake on boot
  programs.plasma.startup.startupScript."yakuake" = {
    runAlways = true;
    text = "yakuake &";
  };

  # keybinds
  programs.plasma.hotkeys.commands."yakuake" = {
    name = "yakuake";
    keys = [
      "F12"
      "Launch Media"
    ];
    command = "yakuake";
  };

  # config file
  programs.plasma.configFile."yakuakerc" = {
    Animation = {
      Frames = 10;
    };
    "Desktop Entry" = {
      DefaultProfile = "yakuake.profile";
    };
    Dialogs = {
      FirstRun = false;
    };
    Shortcuts = {
      close-active-terminal = "none";
      close-session = "Ctrl+W";
      decrease-window-height = "none";
      decrease-window-width = "none";
      file_quit = "none";
      grow-terminal-bottom = "none";
      grow-terminal-left = "none";
      grow-terminal-right = "none";
      grow-terminal-top = "none";
      increase-window-height = "none";
      increase-window-width = "none";
      new-session = "Ctrl+T";
      next-session = "Ctrl+Right";
      next-terminal = "none";
      previous-session = "Ctrl+Left";
      previous-terminal = "none";
      rename-session = "none";
      split-left-right = "none";
      split-top-bottom = "none";
      switch-to-session-1 = "none";
      switch-to-session-10 = "none";
      switch-to-session-2 = "none";
      switch-to-session-3 = "none";
      switch-to-session-4 = "none";
      switch-to-session-5 = "none";
      switch-to-session-6 = "none";
      switch-to-session-7 = "none";
      switch-to-session-8 = "none";
      switch-to-session-9 = "none";
      toggle-session-monitor-activity = "none";
      toggle-session-monitor-silence = "none";
      view-full-screen = "none";
    };
    Window = {
      DynamicTabTitles = true;
      KeepOpen = false;
      ShowTitleBar = false;
    };
  };

  # konsole profile
  xdg.dataFile."konsole/yakuake.profile".text = ''
    [Appearance]
    ColorScheme=yakuake
    Font=DejaVuSans Nerd Font,10,-1,5,50,0,0,0,0,0

    [General]
    Name=yakuake
    Parent=FALLBACK/
  '';

  # color scheme
  programs.plasma.dataFile."konsole/yakuake.colorscheme" = let
    fmt = inputs.nix-colors.lib.conversions.hexToRGBString ","; # TODO: do this myself
  in
    with config.colors; {
      # background
      Background.Color = fmt base01;
      BackgroundIntense.Color = fmt base01;
      # black
      Color0.Color = fmt base01;
      Color0Intense.Color = fmt base02;
      # red
      Color1.Color = fmt base08;
      Color1Intense.Color = fmt base10;
      # green
      Color2.Color = fmt base0B;
      Color2Intense.Color = fmt base13;
      # yellow
      Color3.Color = fmt base0A;
      Color3Intense.Color = fmt base12;
      # blue
      Color4.Color = fmt base0D;
      Color4Intense.Color = fmt base15;
      # purple
      Color5.Color = fmt base0E;
      Color5Intense.Color = fmt base16;
      # cyan
      Color6.Color = fmt base0C;
      Color6Intense.Color = fmt base14;
      # white
      Color7.Color = fmt base06;
      Color7Intense.Color = fmt base07;
      # foreground
      Foreground.Color = fmt base06;
      ForegroundIntense.Color = fmt base06;

      General = {
        Blur = false;
        ColorRandomization = false;
        Description = "yakuake";
        Opacity = 1;
      };
    };
}
