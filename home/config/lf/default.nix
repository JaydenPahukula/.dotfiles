# lf config
{pkgs, ...}: let
  # define packages used
  bat = "${pkgs.bat}/bin/bat";
  pistol = "${pkgs.pistol}/bin/pistol";
  zip = "${pkgs.zip}/bin/zip";
  unzip = "${pkgs.unzip}/bin/unzip";
  file = "${pkgs.file}/bin/file";
  trash = "${pkgs.trashy}/bin/trash";

  wrapper_script = pkgs.writeShellScript "lf_wrapper_script" ''
    # open lf, then cd to the last directory upon close
    cd "$(command lf -print-last-dir "$@")"
  '';

  previewer_script = pkgs.writeShellScript "lf_preview_script" ''
    case "$(${pkgs.file}/bin/file --mime-type -b "$1")" in
      *text/*)
        ${bat} --force-colorization --paging=never --style=changes,numbers --terminal-width $(($2 - 3)) "$1" && false;;
      *)
        ${pistol} "$1";;
    esac
  '';
in {
  # font
  home.packages = with pkgs; [
    nerd-fonts.dejavu-sans-mono
  ];

  # make lf default file explorer
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "lf.desktop";
    };
  };

  # wrapper script
  home.shellAliases.lf = ". ${wrapper_script}";

  # config
  programs.lf = {
    enable = true;

    settings = {
      preview = true;
      dirfirst = false;
      drawbox = true;
      icons = true;
      ignorecase = true;
      wrapscroll = true;
      filesep = " ";
    };

    commands = {
      zip = "%${zip} -rj \"$f.zip\" \"$f\"";
      unzip = ''
        ''${{
                case "$f" in
                  *.zip) ${unzip} "$f" ;;
                  *.tar.gz|*.tgz) tar -xzvf "$f" ;;
                  *.tar.bz2) tar -xjvf "$f" ;;
                  *.tar) tar -xvf "$f" ;;
                  *) echo "Unsupported archive format" ;;
                esac
              }}'';
      open = ''
        ''${{
                case $(${file} --mime-type -bL "$f") in
                  text/*|application/json) $EDITOR "$f";;
                  application/x-executable) "$f";;
                  *) xdg-open "$f" ;;
                esac
              }}'';
      mkdir = ''
        ''${{
                printf "Directory Name: "
                read ans
                mkdir $ans
              }}'';
      mkfile = ''
        ''${{
                printf "File Name: "
                read ans
                $EDITOR $ans
              }}'';
      trash = "%${trash} \"$f\"";
      untrash = "%${trash} restore --force -r 0";
    };

    keybindings = {
      h = "set hidden!"; # toggle hidden files
      c = "copy";
      x = "cut";
      v = "paste";
      "<esc>" = "quit";
      "<enter>" = "open";
      V = "%code $f";
      az = "zip";
      au = "unzip";
      m = "";
      mf = "mkfile";
      md = "mkdir";
      "<delete>" = "trash";
      "<c-delete>" = "untrash";
      "<space>" = "toggle";
      "<c-a>" = "glob-select *";
      "<c-d>" = "unselect";
      r = "rename";
      "<f-2>" = "rename";
    };

    previewer.source = previewer_script;
  };

  # icons
  xdg.configFile."lf/icons".source = ./icons;
}
