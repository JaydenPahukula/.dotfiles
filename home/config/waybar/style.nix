{colors, ...}: {
  programs.waybar.style = with colors; ''
    * {
      font-family: Hack Nerd Font Propo, monospace;
      font-size: 13px;
      padding: 0;
      margin: 0;
    }

    window#waybar {
      background-color: #${base00};
      color: #${base07};
    }

    button {
      border: none;
      border-radius: 0;
    }

    /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
    button:hover {
      background: inherit;
    }

    .modules-right {
      padding-right: 12px;
    }

    #custom-nixlogo {
      font-size: 15px;
    }

    #battery.charging, #battery.plugged {
      color: #${base0B};
    }

    #battery.warning {
      color: #${base0A};
    }

    #temperature.critical {
      color: #${base09};
    }

    #battery.critical, #idle_inhibitor.activated, #network.disconnected {
      color: #${base08};
    }
  '';
}
