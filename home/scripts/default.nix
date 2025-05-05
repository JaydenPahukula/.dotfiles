pkgs: rec {
  logoutPrompt = import ./logoutprompt.nix {inherit pkgs;};
  volumeNotify = import ./volumenotify.nix {inherit pkgs;};
  volumeUp = import ./volumeup.nix {inherit pkgs volumeNotify;};
  volumeDown = import ./volumedown.nix {inherit pkgs volumeNotify;};
  volumeMute = import ./volumemute.nix {inherit pkgs volumeNotify;};
  brightnessNotify = import ./brightnessnotify.nix {inherit pkgs;};
  brightnessDown = import ./brightnessdown.nix {inherit pkgs brightnessNotify;};
  brightnessUp = import ./brightnessup.nix {inherit pkgs brightnessNotify;};
}
