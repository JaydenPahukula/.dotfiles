# bash config
{config, ...}: {
  programs.bash = {
    enable = true;
    bashrcExtra = let
      RESETCOLOR = "\\[\\033[0m\\]";
      RED = "\\[\\033[1;31m\\]";
      GREEN = "\\[\\033[1;32m\\]";
      BLUE = "\\[\\033[1;34m\\]";

      sessionVarsScript = "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh";
    in ''
      PROMPT_COMMAND='
        LAST_EXIT=$?
        if [[ -z $LAST_HISTCMD || $HISTCMD == $LAST_HISTCMD ]]; then
          COMMAND_WAS_RUN=0
        else
          COMMAND_WAS_RUN=1
        fi
        LAST_HISTCMD=$HISTCMD
      '

      PS1='$(if [[ $COMMAND_WAS_RUN == 0 ]]; then echo " "; elif [[ $LAST_EXIT == 0 ]]; then echo "${BLUE}^"; else echo "${RED}^"; fi)${GREEN}[\[\e]0;\u@\h: \w\a\]\u@\h:\w]\''$${RESETCOLOR} ';

      # Source session vars if not already
      . "${sessionVarsScript}"
    '';
  };
}
