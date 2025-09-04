# trash config
{pkgs, ...}: {
  home.packages = with pkgs; [trashy];

  home.shellAliases = {
    # alias to undo the last trash operation
    untrash = "trash restore --force -r 0";
  };
}
