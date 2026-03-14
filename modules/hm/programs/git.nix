# git config
{pkgs, ...}: {
  programs.git = {
    enable = true;
    settings = {
      user.name = "JaydenPahukula";
      user.email = "jayden.pahukula@gmail.com";
      format.pretty = "oneline";
      log.abbrevCommit = true;
      pull.rebase = true;
      alias = {
        "unstage" = "restore --staged";
      };
      core.editor = "${pkgs.vim}/bin/vim";
    };
  };
}
