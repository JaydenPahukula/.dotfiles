{pkgs, ...}: {
  imports = [
    ./lf
    ./plasma
    ./waybar
    ./yakuake
    ./bash.nix
    ./direnv.nix
    ./git.nix
    ./python.nix
    ./trash.nix
    ./vscode.nix
  ];

  # misc programs
  home.packages = with pkgs; [
    btop
    libnotify
    wayland-utils
    wl-clipboard
  ];
}
