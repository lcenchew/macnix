{ pkgs, ... }: {
  # Mac Mini specific settings
  system.defaults = {
    # Keyboard 
    # NSGlobalDomain.InitialKeyRepeat = 15; 
    # NSGlobalDomain.KeyRepeat = 2;
    
    # Dock 
    # dock.static-only = true; # Only show active apps in dock
  };

  # Add Homebrew Applications for Mac Mini only here
  # homebrew.casks = [ "" ];
}
