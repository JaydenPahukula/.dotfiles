# python/pypy config
{pkgs, ...}: {
  # python packages
  home.packages = with pkgs; [
    pypy3
    python312
  ];

  # shell aliases
  home.shellAliases = {
    pypy = "pypy3";
    py = "python3.12";
  };
}
