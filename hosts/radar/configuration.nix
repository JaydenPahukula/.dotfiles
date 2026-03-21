{...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  config = let
    router-ip = "192.168.0.1";
    radar-ip = "192.168.0.99";
  in {
    # internal dns
    services.dnsmasq = {
      enable = true;
      settings = {
        listen-address = ["::1" "127.0.0.1" router-ip]; # only listen to localhost and router
        server = ["1.1.1.1" "71.10.216.1" "71.10.216.2"]; # upstream dns servers
        address = [
          "/router/${router-ip}"
          "/${config.services.grafana.settings.server.domain}/${radar-ip}"
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
          domain = "dashboard.radar";
        };
        analytics.reporting_enabled = false;
      };
    };

    services.vscode-server.enable = true;
  };
}
