# git config
{...}: {
  programs.git = {
    enable = true;
    userName = "JaydenPahukula";
    userEmail = "jayden.pahukula@gmail.com";
    extraConfig = {
      format.pretty = "oneline";
      log.abbrevCommit = true;
      pull.rebase = true;
      alias = {
        "unstage" = "restore --staged";
      };
    };
  };
}
