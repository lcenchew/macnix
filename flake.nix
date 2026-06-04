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
        ];
    };
      templates.default = {
      path = ./modules/examples/flake;
      description = "nix flake init -t macnix";
    };
  };
}
