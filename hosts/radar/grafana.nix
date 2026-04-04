{config, root, ...}: {
  # grafana dashboard
  services.grafana = {
    enable = true;
    settings = {
      server.http_port = 3000;
      server.enforce_domain = true;
      server.enable_gzip = true;
      server.domain = "grafana.jaydenp.dev";
      analytics.reporting_enabled = false;
      users.home_page = "/d/ads58ss/my-dashboard";
    };
    provision = {
      enable = true;
      datasources.settings.prune = true;
      datasources.settings.datasources = [
        {
          name = "prometheus_radar";
          type = "prometheus";
          uid = "P745D6335A62CB152";
          access = "proxy";
          url = "http://${config.services.prometheus.listenAddress}:${toString config.services.prometheus.port}";
          editable = false;
        }
      ];
      dashboards.settings.providers = [{
        name = "my-dashboard";
        disableDeletion = true;
        options = {
          path = "${root}/assets/grafana-dashboards";
        };
      }];
    };
  };

  # reverse proxy
  services.nginx.virtualHosts = {
    "grafana.jaydenp.dev" = {
      useACMEHost = "jaydenp.dev";
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString config.services.grafana.settings.server.http_port}";
        proxyWebsockets = true;
      };
    };
  };
}
