# plasma session manager
{...}: {
  programs.plasma = {
    configFile."ksmserverrc" = {
      "General" = {
        # start with empty session
        "loginMode" = "emptySession";
      };
    };
  };
}
