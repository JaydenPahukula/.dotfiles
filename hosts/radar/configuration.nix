{config, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  config = {
    time.timeZone = "America/Chicago";

    networking.firewall = {
      allowedUDPPorts = [53];
      allowedTCPPorts = [53 80 443];
    };

    # internal dns
    services.dnsmasq = {
      enable = true;
      alwaysKeepRunning = true;
      settings = {
        local-service = "net"; # only listen to local network
        server = ["1.1.1.1" "71.10.216.1" "71.10.216.2"]; # upstream dns servers
        address = [
          "/grafana.jaydenp.dev/192.168.0.99"
        ];
      };
    };

    # grafana dashboard
    services.grafana = {
      enable = true;
      settings = {
        server = {
          http_port = 3000;
          enforce_domain = true;
          enable_gzip = true;
          domain = "grafana.jaydenp.dev";
        };
        analytics.reporting_enabled = false;
      };
    };

    services.nginx = {
      enable = true;
      recommendedTlsSettings = true;
      recommendedProxySettings = true;
      virtualHosts = {
        "grafana.jaydenp.dev" = {
          useACMEHost = "jaydenp.dev";
          forceSSL = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:${toString config.services.grafana.settings.server.http_port}";
            proxyWebsockets = true;
          };
        };
      };
    };
    users.users.nginx.extraGroups = ["acme"];

    security.acme = {
      acceptTerms = true;
      defaults.email = "jayden.pahukula@gmail.com";
      certs = {
        "jaydenp.dev" = {
          domain = "*.jaydenp.dev";
          dnsProvider = "cloudflare";
          credentialsFile = "/run/secrets/cloudflare";
          dnsPropagationCheck = true;
        };
      };
    };

    services.vscode-server.enable = true;
  };
}
