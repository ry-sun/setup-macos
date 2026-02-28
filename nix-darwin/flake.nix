{
  description = "Setup Macos via nix-darwin";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    args = import ./args.nix;
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#RySun-Macbook-Air-M2
    darwinConfigurations."${args.hostname}" = nix-darwin.lib.darwinSystem {
      specialArgs = {
          inherit self;
          inherit args;
        };
      modules = [ ./base.nix ];
    };
  };
}
