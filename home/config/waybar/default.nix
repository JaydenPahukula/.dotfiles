# waybar config
{
  config,
  pkgs,
  scripts,
  ...
}: {
  imports = [
    ./style.nix
  ];

  home.packages = with pkgs; [
    nerd-fonts.hack
    # cava
  ];

  # start on boot
  programs.plasma.startup.startupScript."waybar" = {
    runAlways = true;
    text = "waybar &";
  };

  # main config
  programs.waybar = {
    enable = true;

    settings."mainBar" = {
      layer = "bottom"; # so yakuake goes above it
      position = "top";
      height = 24;
      spacing = 20;

      modules-left = [
        "custom/nixlogo"
        "clock"
      ];
      modules-center = [];
      modules-right = [
        # "cava"
        "idle_inhibitor"
        "network"
        "memory"
        "cpu"
        "temperature"
        "battery"
      ];

      "custom/nixlogo" = {
        format = "  ";
        tooltip = false;
        on-click = ". ${scripts.logoutPrompt}";
      };

      clock = {
        interval = 1;
        format = "{:%I:%M %p %a, %b %d}";
        tooltip-format = "<big>{:%I:%M:%S}</big>";
      };

      # cava = {
      #   framerate = 60;
      #   autosens = 1;
      #   bars = 12;
      #   method = "pulse";
      #   source = "auto";
      #   stereo = false;
      #   bar_delimiter = 0;
      #   noise_reduction = 0.2;
      #   monstercat = false;
      #   waves = false;
      #   input_delay = 2;
      #   format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
      # };

      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
        };
        tooltip-format-activated = "Idle inhibitor: on";
        tooltip-format-deactivated = "Idle inhibitor: off";
      };

      network = {
        interval = 10;
        format-wifi = "{essid} ({signalStrength}%) ";
        format-ethernet = "{ipaddr}/{cidr} ";
        format-linked = "{ifname} (No IP) ";
        format-disconnected = "Disconnected ⚠";
        tooltip-format = "IP = {ipaddr}/{cidr}\nOn {ifname} via {gwaddr}\n\n{bandwidthDownBits}   {bandwidthUpBits} ";
      };

      memory = {
        interval = 3;
        format = "Mem {}%";
        tooltip-format = "{used:0.1f}GB out of {total:0.1f}GB";
      };

      cpu = {
        interval = 3;
        format = "CPU {usage}%";
      };

      temperature = {
        interval = 3;
        thermal-zone = 2;
        critical-threshold = 60;
      };

      battery = {
        interval = 10;
        states = {
          warning = 20;
          critical = 10;
        };
        format = "{capacity}% {icon}";
        format-full = "{capacity}% {icon}";
        format-charging = "{capacity}% ";
        format-plugged = "{capacity}% ";
        format-tooltip = "Time to empty: {time}";
        format-icons = [
          ""
          ""
          ""
          ""
          ""
        ];
      };
    };
  };
}
