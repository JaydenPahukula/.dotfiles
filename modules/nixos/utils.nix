{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    brightnessctl
    file
    hostname
    killall
    neofetch
    nix-tree
    openssl
    playerctl
    python312
    traceroute
    unzip
    vim
    wget
    wirelesstools
    zip
  ];
}
