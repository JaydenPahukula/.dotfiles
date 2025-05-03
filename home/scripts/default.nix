{pkgs}: rec {
  logoutPrompt = import ./logoutprompt.nix {inherit pkgs;};
  volumeNotify = import ./volumenotify.nix {inherit pkgs;};
  volumeUp = import ./volumeup.nix {inherit pkgs volumeNotify;};
  volumeDown = import ./volumedown.nix {inherit pkgs volumeNotify;};
  volumeMute = import ./volumemute.nix {inherit pkgs volumeNotify;};
}
