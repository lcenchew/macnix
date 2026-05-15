{
  description = "A configurable macOS Nix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }: {
    darwinConfigurations."current-host" = nix-darwin.lib.darwinSystem {
        modules = [ 
          ./common.nix
          ./current-host.nix 
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;  # for Apple Silicon Macs
              user = "USER_REPLACE"; # updated by apply script
              autoMigrate = true;    # migrates existing brew if any
            };
          }
        ];
    };
  };
}
