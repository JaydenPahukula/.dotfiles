# vscode-server
{inputs, ...}: {
  # this module allows clients to remote ssh in with vscode
  imports = [
    inputs.vscode-server.nixosModules.default
  ];
}
