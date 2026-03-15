# plasma-manager spectacle module
{...}: {
  programs.plasma.spectacle = {
    # disable unused shortcuts
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
}
