# git config
{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.programs.git.enable {
    programs.git.settings = {
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
