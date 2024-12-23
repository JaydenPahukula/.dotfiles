# python/pypy config
{pkgs, ...}: {
  # specify packages
  home.packages = with pkgs; [
    pypy3
    # python312 <-- already installed globally
  ];

  # shell aliases
  home.shellAliases = {
    pypy = "pypy3";
    py = "python3.12";
  };
}
