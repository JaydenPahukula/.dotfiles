{
  config,
  root,
  ...
}: {
  imports = [
    ./grafana.nix
    ./hardware-configuration.nix
    ./prometheus.nix
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
          "/prometheus.jaydenp.dev/192.168.0.99"
        ];
      };
    };

    services.nginx = {
      enable = true;
      recommendedTlsSettings = true;
      recommendedProxySettings = true;
    };
    users.users.nginx.extraGroups = ["acme"];

    security.acme = {
      acceptTerms = true;
      defaults.email = "jayden.pahukula@gmail.com";
      certs = {
        "jaydenp.dev" = {
          domain = "*.jaydenp.dev";
          dnsProvider = "cloudflare";
          environmentFile = config.sops.secrets."cloudflare.env".path;
          dnsPropagationCheck = true;
        };
      };
    };

    sops = {
      enable = true;
      secrets = {
        "cloudflare.env".sopsFile = "${root}/secrets/host_radar.yaml";
      };
    };

    services.vscode-server.enable = true;
  };
}
