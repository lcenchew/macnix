{
  description = "A basic configuration of macOS using Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nix-darwin, nixpkgs }: {
    # use this to setup:  `sudo -H nix run nix-darwin -- switch --flake .#janmacbook`
    darwinConfigurations."janmacbook" = nix-darwin.lib.darwinSystem {
      modules = [
        ({ pkgs, ... }: {
          nixpkgs.hostPlatform = "aarch64-darwin";
          # Allow proprietary packages
          nixpkgs.config.allowUnfree = true;

          # Define system-wide packages for all users
          environment.systemPackages = [
            pkgs.brave
            pkgs.vscode
            pkgs.tailscale
            pkgs.git
            pkgs.htop
          ];

          services.tailscale.enable = true;

          system.primaryUser = "whoami";        # update username here
          system.defaults = {

            # Dock 
            dock.tilesize = 24;
            dock.magnification = true;
            dock.largesize = 64;
            # Remove all the default and set own apps
            dock.persistent-apps = [
              "/System/Applications/Mission Control.app"
              "/Applications/Nix Apps/Brave Browser.app"
              "/Applications/Nix Apps/Visual Studio Code.app"
              "/System/Applications/System Settings.app"
              "/System/Applications/Utilities/Disk Utility.app"
              "/System/Applications/Utilities/Activity Monitor.app"
              "/System/Applications/Utilities/Screen Sharing.app"
            ];
            dock.persistent-others = [
              "/Users/whoami/Downloads"         # update username here
            ];

            # Disable Spaces from changing order
            dock.mru-spaces = false;
            
            # Enable tap-to-click
            trackpad.Clicking = true;           
            
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
                  "com.apple.finder.NFLD" # Add New Folder button!
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
          
          # Set compatibility state version (do not change once deployed)
          # For latest value, check `system.stateVersion` in 
          # https://github.com/nix-darwin/nix-darwin/blob/master/modules/system/version.nix
          system.stateVersion = 7;
        })
      ];
    };

    # Allow to pull this file as a template from github
    # `nix flake init -t "github:lcenchew/macnix"` 
    templates.default = {
      path = ./.;
      description = "Template for https://github.com/lcenchew/macnix";
    }; 
  };
}
