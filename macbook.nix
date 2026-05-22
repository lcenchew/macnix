{ pkgs, ... }: {
  # MacBook specific settings

  nixpkgs.hostPlatform = "PLATFORM_REPLACE";

  system.primaryUser = "USER_REPLACE";

  homebrew.prefix = "HOMEBREW_PREFIX_REPLACE";

  nix-homebrew = {
    enable = true;
    user = "USER_REPLACE";
    autoMigrate = true;
    prefixes = {
      "HOMEBREW_PREFIX_REPLACE" = {
        enable = true;
        library = "HOMEBREW_PREFIX_REPLACE/Library";
      };
    };
  };
  
  system.defaults = {
    # Trackpad
    trackpad.Clicking = true;           # Enable tap-to-click
     
    # Dock
    # dock.autohide = false;              # Autohide dock to save screen real estate
  };

  # Add Homebrew Applications for Macbook only here
  # homebrew.casks = [ "" ];
}
