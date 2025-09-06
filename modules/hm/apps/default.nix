{pkgs, ...}: {
  imports = [
    ./chrome.nix
    ./vscode.nix
  ];

  # other default apps
  home.packages = with pkgs; [
    gnome-disk-utility
  ];
}
