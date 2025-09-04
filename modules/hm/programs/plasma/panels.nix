# plasma panels
# NOTE: if panels don't update after reboot, try running ~/.local/share/plasma-manager/run_all.sh
{...}: {
  # disable all panels
  programs.plasma.panels = [];
}
