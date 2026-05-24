{ pkgs, ... }: {
  # Mac Mini specific settings

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
    # Keyboard 
    # NSGlobalDomain.InitialKeyRepeat = 15; 
    # NSGlobalDomain.KeyRepeat = 2;
    
    # Dock 
    # dock.static-only = true; # Only show active apps in dock
  };

  # Add Homebrew Applications for Mac Mini only here
  # (Listed for my convenience. Edit accordingly. )
  homebrew.casks = [ 
    "iterm2"
    "keepassxc"
    "antigravity"
    "google-drive"
  ];
}
