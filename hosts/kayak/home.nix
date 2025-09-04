# kayak home manager configuration
{
  pkgs,
  root,
  ...
}: {
  wallpaper = "${root}/assets/wallpapers/windrises.png";

  # set default display scale/position
  programs.plasma.startup.startupScript."displaySetup" = {
    runAlways = true;
    text = let
      kscreen-doctor = "${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor";
    in ''
      ${kscreen-doctor} \
        output.1.scale.1.3 \
        output.1.position.0,0 \
      ${kscreen-doctor} \
        output.2.scale.1 \
        output.2.position.-1920,0 \
    '';
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0" # obsidian needs this
  ];

  home.packages = with pkgs; [
    # apps
    discord
    gimp
    kdePackages.kate
    libreoffice-qt6
    obsidian
    postman
    spotify

    alejandra
    nixd

    # games
    prismlauncher
    smassh
  ];
}
