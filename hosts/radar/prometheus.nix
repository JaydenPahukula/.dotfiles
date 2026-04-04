{config, ...}: {
  services.prometheus = {
    enable = true;
    listenAddress = "127.0.0.1";
    port = 9090;
    stateDir = "prometheus2"; # /var/lib/prometheus2 (see bind mount below)
    retentionTime = "30d";
    globalConfig.scrape_interval = "15s";
    globalConfig.scrape_timeout = "15s";

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
        extraFlags = ["--collector.disable-defaults"]; # disable all connectors except for the ones specified below
        enabledCollectors = [
          "cpu"
          "loadavg"
          "meminfo"
          "vmstat"
          "filesystem"
          "diskstats"
          "netdev"
          "netstat"
          "sockstat"
          "hwmon"
          "stat"
          "time"
          "filefd"
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
