# klipper (for clipboard history)
{pkgs, ...}: {
  programs.plasma = {
    # start on boot
    startup.startupScript."klipper" = {
      runAlways = true;
      text = "${pkgs.libsForQt5.plasma-workspace}/bin/klipper &";
    };
    # config
    configFile."klipperrc" = {
      "General" = {
        "SyncClipboards" = false;
        "IgnoreSelection" = true;
        "IgnoreImages" = false;
        "SelectionTextOnly" = true;
      };
    };
  };
}
