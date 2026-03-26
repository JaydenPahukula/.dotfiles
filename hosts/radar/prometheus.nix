{config, ...}: {
  services.prometheus = {
    enable = true;
    port = 9090;
    stateDir = "prometheus2"; # /var/lib/prometheus2
    retentionTime = "15d";
    globalConfig.scrape_interval = "1m";
    globalConfig.scrape_timeout = "10s";

    scrapeConfigs = [
      {
        job_name = "node";
        static_configs = [
          {
            targets = ["localhost:${toString config.services.prometheus.exporters.node.port}"];
          }
        ];
      }
    ];

    exporters = {
      node = {
        enable = true;
        port = 9000;
        # For the list of available collectors, run, depending on your install:
        # - Flake-based: nix run nixpkgs#prometheus-node-exporter -- --help
        # - Classic: nix-shell -p prometheus-node-exporter --run "node_exporter --help"
        enabledCollectors = [
          "ethtool"
          "cpu.info"
          "softirqs"
          "systemd"
          "tcpstat"
          "wifi"
        ];
      };
    };
  };

  # bind mount prometheus data storage into /data
  fileSystems."/var/lib/prometheus2" = {
    device = "/data/prometheus";
    options = ["bind"];
  };

  # reverse proxy
  services.nginx.virtualHosts = {
    "prometheus.jaydenp.dev" = {
      useACMEHost = "jaydenp.dev";
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString config.services.prometheus.port}";
        proxyWebsockets = true;
      };
    };
  };
}
