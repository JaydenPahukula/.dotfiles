# kscreenlocker
{config, ...}: {
  programs.plasma.kscreenlocker = {
    lockOnResume = true;
    lockOnStartup = false;
    autoLock = false;

    passwordRequired = true;
    passwordRequiredDelay = 5;

    appearance = {
      alwaysShowClock = true;
      showMediaControls = false;
      wallpaper = config.programs.plasma.workspace.wallpaper;
    };
  };
}
