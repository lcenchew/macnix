{ pkgs, ... }: {
  # MacBook specific settings
  system.defaults = {
    # Trackpad
    trackpad.Clicking = true;           # Enable tap-to-click
     
    # Dock
    # dock.autohide = false;              # Autohide dock to save screen real estate
  };

  # Add Homebrew Applications for Macbook only here
  # homebrew.casks = [ "" ];
}
