# theme colors
{nix-colors, ...}: {
  imports = [nix-colors.homeManagerModules.default];

  colorScheme = {
    palette = {
      base00 = "#151515"; # ----
      base01 = "#212121"; # ---
      base02 = "#333333"; # --
      base03 = "#757575"; # -
      base04 = "#959595"; # +
      base05 = "#B5B5B5"; # ++
      base06 = "#CBCBCB"; # +++
      base07 = "#F0F0F0"; # ++++

      base08 = "#db3030"; # red
      base09 = "#f09724"; # orange
      base0A = "#fad32f"; # yellow
      base0B = "#65cf48"; # green
      base0C = "#13bdbd"; # aqua
      base0D = "#2494c8"; # blue
      base0E = "#bc3fbc"; # magenta
      base0F = "#9c5916"; # brown

      base10 = "#f04a4a"; # light red
      base11 = "#f5a640"; # light orange
      base12 = "#f7db63"; # light yellow
      base13 = "#7fe065"; # light green
      base14 = "#2bccc7"; # light aqua
      base15 = "#48bbf0"; # light blue
      base16 = "#d670d6"; # light magenta
      base17 = "#d9ab66"; # light brown

      spotify = "#1db954";
    };
  };
}
