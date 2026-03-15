# plasma panels
{...}: {
  # disable all panels
  programs.plasma.panels = [];
  # delete all panels every time (not sure why this is necessary)
  programs.plasma.startup.desktopScript."clear-panels" = {
    runAlways = true;
    text = ''
      panels().forEach((panel) => panel.remove());
    '';
  };
}
