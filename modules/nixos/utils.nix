{
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    brightnessctl
    efibootmgr
    file
    inetutils
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
    "EDITOR" = lib.mkOverride 500 "${pkgs.vim}/bin/vim";
  };
}
