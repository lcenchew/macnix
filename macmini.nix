{ pkgs, ... }: {
  # Specific settings for Mac Mini (Performance/Desktop etc.)
  system.defaults = {
    # Faster key repeat 
    NSGlobalDomain.InitialKeyRepeat = 15; 
    NSGlobalDomain.KeyRepeat = 2;
    
    # Desktop specific 
    dock.static-only = true; # Only show active apps in dock
  };

  # Apps installed by Homebrew
  # homebrew.casks = [ "" "" ];
}
