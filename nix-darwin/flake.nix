{
  description = "Setup MacOS via nix-darwin.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
    }:
    let
      args = import ../arguments.nix;
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Whos-MacBook-Air
      darwinConfigurations."${args.hostname}" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit args;
          inherit self;
        };
        modules = [
          ./configuration.nix
        ];
      };
    };
}
