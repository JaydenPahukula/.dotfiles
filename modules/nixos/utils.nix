{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    brightnessctl
    efibootmgr
    file
    hostname
    killall
    neofetch
    nix-tree
    openssl
    playerctl
    python312
    traceroute
    tree
    unzip
    vim
    wget
    wirelesstools
    zip
  ];

  environment.variables = {
    "EDITOR" = "vim";
  };
}
