{config, ...}: {
  # grafana dashboard
  services.grafana = {
    enable = true;
    settings = {
      server.http_port = 3000;
      server.enforce_domain = true;
      server.enable_gzip = true;
      server.domain = "grafana.jaydenp.dev";
      analytics.reporting_enabled = false;
    };
    # provision = {
    #   datasources.settings.datasources = [
    #     # Provisioning a built-in data source
    #     {
    #       name = "Prometheus";
    #       type = "prometheus";
    #       url = "http://${config.services.prometheus.listenAddress}:${toString config.services.prometheus.port}";
    #       isDefault = true;
    #       editable = false;
    #     }
    #   ];
    # };
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
