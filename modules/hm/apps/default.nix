{pkgs, ...}: {
  imports = [
    ./chrome.nix
    ./kate.nix
    ./vscode.nix
  ];

  # other default apps
  home.packages = with pkgs; [
    gparted
  ];
}
