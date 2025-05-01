# bash config
{...}: {
  programs.bash = {
    enable = true;
    bashrcExtra = let
      # custom prompt
      PS1 = ''\[\033[1;\$(if [ \$? == 0 ]; then echo 34; else echo 31; fi)m\]*\[\033[1;32m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\$\[\033[0m\] '';
    in ''
      export PS1="${PS1}";
    '';
  };
}
