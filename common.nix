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
    onActivation.cleanup = "zap"; # Removes apps not listed here for total control

    casks = [
      "google-chrome"
      "brave-browser"
      "firefox"
    ];
  };

  # for nix-darwin to work with the Nix daemon
  services.nix-daemon.enable = true;

  # Enable Flakes and the new 'nix' command line tool
  nix.settings.experimental-features = "nix-command flakes";

  # Used for backwards compatibility, read the changelog before changing.
  # $ darwin-rebuild changelog
  # This value determines the default settings for various system services.
  # It should generally be kept at the version that was originally installed.
  # DO NOT change this unless you know why
  system.stateVersion = 5;
}
