# default user-level config for my desktop machines
{
  host,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (host.type == "desktop") {
    home.packages = with pkgs; [
      libnotify
      wayland-utils
      wl-clipboard

      gparted
    ];

    services.mako.enable = true;

    programs.plasma.enable = true;

    programs.discord.enable = true;
    programs.kate.enable = true;
    programs.python.enable = true;
    programs.ssh.enable = true;
    programs.ssh.enableDefaultConfig = false;
    programs.trash.enable = true;
    programs.vscode.enable = true;
    programs.waybar.enable = true;
    programs.yakuake.enable = true;
  };
}
