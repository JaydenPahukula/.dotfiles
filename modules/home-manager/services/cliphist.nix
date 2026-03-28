{
  config,
  lib,
  pkgs,
  ...
}: {
  config = let
    # clipboard script
    cliphist-script = pkgs.writeShellScript "cliphist" ''
      ${config.services.cliphist.package}/bin/cliphist list | \
      ${config.programs.rofi.package}/bin/rofi -dmenu | \
      ${config.services.cliphist.package}/bin/cliphist decode | \
      ${config.services.cliphist.clipboardPackage}/bin/wl-copy && \
      ${pkgs.wtype}/bin/wtype -M ctrl -m v
    '';
  in
    lib.mkIf config.services.cliphist.enable {
      services.cliphist = {
        allowImages = true;
        clipboardPackage = pkgs.wl-clipboard-rs;
      };

      programs.rofi = {
        enable = true;
      };

      # shortcut (win+v)
      programs.plasma.hotkeys.commands."cliphist" = {
        name = "Clipboard History";
        key = "Meta+V";
        command = "${cliphist-script}";
      };
    };
}
