# plasma theme
{pkgs, ...}: {
  home.packages = with pkgs; [
    hackneyed
  ];

  programs.plasma = {
    workspace.cursor.theme = "Hackneyed";
  };
}
