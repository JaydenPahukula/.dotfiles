# fonts
{
  config,
  host,
  lib,
  ...
}: {
  options.fonts.disabled = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [];
    example = ["Noto Sans"];
    description = ''
      A list of font families to disable on the system.
    '';
  };

  config = lib.mkIf (host.type == "desktop") {
    fonts.fontconfig.enable = true;

    xdg.configFile."fontconfig/conf.d/78-disable-fonts.conf".text = let
      mkPattern = s: "\n      <pattern><patelt name=\"family\"><string>${s}</string></patelt></pattern>";
    in ''
      <?xml version="1.0"?>
      <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
      <fontconfig>
        <selectfont>
          <rejectfont>${lib.strings.concatMapStrings mkPattern config.fonts.disabled}
          </rejectfont>
        </selectfont>
      </fontconfig>
    '';
  };
}
