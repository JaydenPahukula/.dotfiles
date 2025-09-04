{pkgs, ...}: {
  imports = [
    ./chrome.nix
  ];

  # other default apps
  home.packages = with pkgs; [
    gnome-disk-utility
  ];
}
