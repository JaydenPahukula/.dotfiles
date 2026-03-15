# waybar config
{
  config,
  lib,
  pkgs,
  ...
}: {
  options.programs.waybar = {
    temp.thermal-zone = lib.mkOption {
      type = lib.types.nullOr lib.types.number;
      default = null;
      description = ''
        The number of the thermal zone to use for the tempurature module.

        Available thermal zones are listed in `/sys/class/thermal/`.
      '';
    };
    gpu.hwmon-path = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = "/sys/class/hwmon/hwmon1/device/gpu_busy_percent";
      description = ''
        Path to the hwmon file containing GPU usage. The GPU module will not be
        displayed unless this is defined.

        Note that this is a string and not a path, so that nixos will not symlink it.
      '';
    };
  };

  imports = [
    ./style.nix
  ];

  config = {
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
          "custom/gpu"
          "cpu"
          "temperature"
          "battery"
        ];

        "custom/nixlogo" = {
          format = "  ";
          tooltip = false;
          on-click = ". ${pkgs.writeShellScript "logout-prompt" ''
            ${pkgs.kdePackages.qttools}/bin/qdbus org.kde.LogoutPrompt /LogoutPrompt promptAll
          ''}";
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
          format-ethernet = "Wired ";
          format-linked = "Linked (No IP) ";
          format-disconnected = "Disconnected ⚠";
          tooltip-format = "IP = {ipaddr}/{cidr}\nOn {ifname} via {gwaddr}\n\n{bandwidthDownBits}   {bandwidthUpBits} ";
        };

        memory = {
          interval = 3;
          format = "Mem {}%";
          tooltip-format = "{used:0.1f}GB out of {total:0.1f}GB";
        };

        "custom/gpu" = lib.mkIf (config.programs.waybar.gpu.hwmon-path != null) {
          exec = "cat ${config.programs.waybar.gpu.hwmon-path} 2>/dev/null || echo error";
          format = "GPU {}%";
          interval = 3;
        };

        cpu = {
          interval = 3;
          format = "CPU {usage}%";
        };

        temperature = {
          interval = 3;
          thermal-zone = config.programs.waybar.temp.thermal-zone;
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
  };
}
