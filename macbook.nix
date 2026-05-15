{ pkgs, ... }: {
  # MacBook specific settings
  system.defaults = {
    trackpad.Clicking = true;           # Enable tap-to-click
    dock.autohide = false;               # Autohide dock to save screen real estate
  };

  # Add Applications installed by Homebrew here
  # homebrew.casks = [ "" ];
}
