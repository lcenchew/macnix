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
    dock.tilesize = 24;
    dock.magnification = true;
    dock.largesize = 64;
    dock.persistent-apps = [
      "/System/Applications/Mission Control.app"
      "/nix/homebrew/Applications/Brave Browser.app"
      "/nix/homebrew/Applications/Firefox.app"
      "/nix/homebrew/Applications/Google Chrome.app"
      "/System/Applications/System Settings.app"
      "/System/Applications/Utilities/Disk Utility.app"
      "/System/Applications/Utilities/Activity Monitor.app"
      "/System/Applications/Utilities/Screen Sharing.app"
    ];
    dock.persistent-others = [
      "/Users/USER_REPLACE/Downloads"
    ];

    # Finder
    finder.AppleShowAllExtensions = true;
    finder.AppleShowAllFiles = true;
    finder._FXSortFoldersFirst = true;
    finder._FXSortFoldersFirstOnDesktop = true; 
    finder.ShowPathbar = true;
    finder.ShowStatusBar = true;
    finder.FXPreferredViewStyle = "clmv"; # Column View
    finder.QuitMenuItem = true;
    finder.FXEnableExtensionChangeWarning = false;
    finder.NewWindowTarget = "Home";
    finder.FXDefaultSearchScope = "SCvm"; # Options: current folder "SCcf", This Mac "SCpc", or last search "SCvm"

    # Finder toolbar 
    CustomUserPreferences."com.apple.finder" = {
      "NSToolbar Configuration Browser" = {
        "TB Display Mode" = 2;
        "TB Icon Size Mode" = 1;
        "TB Is Shown" = 1;
        "TB Size Mode" = 1;
      
        "TB Item Identifiers" = [
          "com.apple.finder.BACK"
          "com.apple.finder.NFLD" # <-- This is your New Folder button!
          "com.apple.finder.SWCH"
          "NSToolbarSpaceItem"
          "com.apple.finder.ARNG"
          "NSToolbarSpaceItem"
          "com.apple.finder.SHAR"
          "com.apple.finder.LABL"
          "com.apple.finder.ACTN"
          "NSToolbarSpaceItem"
          "com.apple.finder.SRCH"
        ];
      };
    };
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
