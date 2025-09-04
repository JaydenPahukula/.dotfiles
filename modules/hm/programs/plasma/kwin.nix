# kwin
{...}: {
  programs.plasma = {
    # disable hot corners
    configFile."kwinrc" = {
      "Effect-overview" = {
        "BorderActivate" = 9;
      };
    };

    kwin = {
      edgeBarrier = 50;
    };
  };
}
