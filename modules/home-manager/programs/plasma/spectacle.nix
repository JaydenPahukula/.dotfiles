# plasma-manager spectacle module
{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.programs.plasma.enable {
    programs.plasma.spectacle = {
      # disable some unused shortcuts
      shortcuts = {
        captureActiveWindow = "";
        captureCurrentMonitor = "";
        captureEntireDesktop = "";
        captureRectangularRegion = "Print";
        captureWindowUnderCursor = "";
        launch = "";
        launchWithoutCapturing = "";
        recordRegion = "";
        recordScreen = "";
        recordWindow = "";
      };
    };
  };
}
