{ pkgs, ... }: {
  # MacBook specific settings
  nixpkgs.hostPlatform = "PLATFORM_REPLACE";

  system.primaryUser = "USER_REPLACE";
  system.defaults = {
    # Trackpad
    trackpad.Clicking = true;           # Enable tap-to-click
     
    # Dock
    # dock.autohide = false;              # Autohide dock to save screen real estate
  };

  # Add Homebrew Applications for Macbook only here
  # homebrew.casks = [ "" ];
}
