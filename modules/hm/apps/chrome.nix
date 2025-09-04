# google chrome config
{pkgs, ...}: {
  # install package
  home.packages = [
    pkgs.google-chrome
  ];

  # make chrome default for supported mime types
  xdg.mimeApps = let
    chromeMimeTypes = [
      "application/pdf"
      "application/rdf+xml"
      "application/rss+xml"
      "application/xhtml+xml"
      "application/xhtml_xml"
      "application/xml"
      "image/gif"
      "image/jpeg"
      "image/png"
      "image/webp"
      "text/html"
      "text/xml"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
    ];
  in {
    enable = true;
    defaultApplications = builtins.listToAttrs (
      builtins.map (type: {
        name = type;
        value = "google-chrome.desktop";
      })
      chromeMimeTypes
    );
  };
}
