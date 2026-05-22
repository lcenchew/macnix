{ pkgs, ... }: {
  # List of packages to install on every machine
  environment.systemPackages = [ 
    pkgs.git    # Version control
    pkgs.vim    # Terminal editor
    pkgs.htop   # System monitor
    pkgs.curl   # Data transfer tool
  ];

  # Homebrew management
  homebrew = {
    enable = true;

    # https://nix-darwin.github.io/nix-darwin/manual/#opt-homebrew.onActivation.cleanup
    onActivation.cleanup = "zap"; # Removes apps not listed here to fully manage by Nix

    casks = [
      "google-chrome"
      "brave-browser"
      "firefox"
      "tailscale-app"
    ];
  };

  # Determinate uses its own daemon to manage the Nix installation
  # Turn off nix-darwin’s management of the Nix installation
  nix.enable = false;

  # Used for backwards compatibility, read the changelog before changing.
  # $ darwin-rebuild changelog
  # This value determines the default settings for various system services.
  # It should generally be kept at the version that was originally installed.
  # DO NOT change this unless you know why
  system.stateVersion = 5;
}
