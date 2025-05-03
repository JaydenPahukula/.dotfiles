# script to launch plasma logout prompt
{pkgs}:
pkgs.writeShellScript "logout-prompt" ''
  qdbus org.kde.LogoutPrompt /LogoutPrompt promptAll
''
