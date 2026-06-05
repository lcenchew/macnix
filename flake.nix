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
